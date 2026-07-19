# Retire l'alias "gswm" au profit de "gswm()"
unalias gswm 2>/dev/null

# Supprime les branches locales retirées du dépôt
gfp() {
	gf --prune
	git for-each-ref --format='%(refname:short) %(upstream:track)' refs/heads |
		grep '\[gone\]' |
		awk '{print $1}' |
		while IFS= read -r branch; do
			gbD "$branch"
		done
}

# Crée une merge request (github ou gitlab)
gmr() {
	if [[ "$1" == "--help" || "$1" == "-h" ]]; then
		echo "Usage : gmr <type> <slug-description> [issue-id]"
		return 0
	fi

	local type="$1"
	local slug_description="$2"
	local issue_id="$3"

	local branch="${type}/${slug_description}"
	[[ -n "$issue_id" ]] && branch="${branch}-${issue_id}"

	gswc "$branch" || return 1
	gp -u origin "$branch" || return 1

	local remote_url="$(git remote get-url origin)"
	local template_path platform

	if [[ "$remote_url" == *"github.com"* ]]; then
		platform="github"
		template_path=".github/PULL_REQUEST_TEMPLATE.md"
	elif [[ "$remote_url" == *"gitlab"* ]]; then
		platform="gitlab"
		template_path=".gitlab/merge_request_templates/default.md"
	else
		echo "Remote non reconnu : $remote_url"
		return 1
	fi

	local description
	description=$(
		{
			[[ -n "$issue_id" ]] && echo "Closes ${issue_id}"
			echo
			[[ -f "$template_path" ]] && cat "$template_path"
		}
	)

	local target_branch="$(git_main_branch)"

	if [[ "$platform" == "github" ]]; then
		gh pr create \
			--assignee @me \
			--base "$target_branch" \
			--body "$description" \
			--draft \
			--title "$branch"
	else
		glab mr create \
			--description "$description" \
			--draft \
			--no-editor \
			--remove-source-branch \
			--target-branch "$target_branch" \
			--title "$branch" \
			--yes
	fi
}

# Bascule sur la branche principale et récupère les modifications du dépôt
gswm() {
	gsw $(git_main_branch)
	gpr
	gfp
}

# Crée une clé SSH
sshn() {
	local name passphrase host user key

	read "name?Nom de la clé (ex : github, glab-pro) : "
	[[ -z "$name" ]] && return 1

	key="$HOME/.ssh/$name"

	if [[ -e "$key" || -e "$key.pub" ]]; then
		echo
		echo "La clé '$name' existe déjà."
		return 1
	fi

	read -s "passphrase?Passphrase (recommandé) : "
	echo

	read "host?Domaine / IP du serveur (ex : github.com) : "
	[[ -z "$host" ]] && return 1

	read "user?Utilisateur (ex : git) : "
	[[ -z "$user" ]] && return 1

	mkdir -p "$HOME/.ssh"
	chmod 700 "$HOME/.ssh"

	ssh-keygen \
		-t ed25519 \
		-a 100 \
		-N "$passphrase" \
		-C "$name" \
		-f "$key" || return 1

	cat >>"$HOME/.ssh/config" <<EOF

Host $name
    HostName $host
    User $user
    IdentityFile $key
    AddKeysToAgent yes
    UseKeychain yes
    IdentitiesOnly yes
EOF

	chmod 600 "$HOME/.ssh/config"

	if [[ -n "$passphrase" ]]; then
		echo "Ajout de la clé au trousseau d'accès (la passphrase va être redemandée)..."
		ssh-add --apple-use-keychain "$key"
	fi

	pbcopy <"$key.pub"
	echo
	echo "La clé '$name' a bien été ajoutée et copiée dans le presse-papier."
}

# Copie une clé SSH
sshg() {
	if [[ "$1" == "--help" || "$1" == "-h" ]]; then
		echo "Usage : sshg <name>"
		return 0
	fi

	local name="$1"

	if [[ -z "$name" ]]; then
		echo "Clés SSH existantes :"
		echo
		for key in "$HOME"/.ssh/*.pub; do
			[[ -f "$key" ]] || continue
			basename "$key" .pub
		done
		return 0
	fi

	pbcopy <"$HOME/.ssh/$name.pub"
	echo "La clé '$name' a bien été copiée dans le presse-papier."
}

# Supprime une clé SSH
sshrm() {
	if [[ "$1" == "--help" || "$1" == "-h" ]]; then
		echo "Usage : sshrm <name>"
		return 0
	fi

	local name="$1"

	if [[ -z "$name" ]]; then
		sshg
		return 1
	fi

	local key="$HOME/.ssh/$name"

	if [[ ! -f "$key.pub" ]]; then
		sshg
		return 1
	fi

	ssh-add -d "$key" >/dev/null 2>&1
	rm -f "$key" "$key.pub"

	if [[ -f "$HOME/.ssh/config" ]]; then
		sed -i '' "/^Host $name$/,/^$/d" "$HOME/.ssh/config"
	fi

	echo "La clé '$name' a bien été supprimée, il faut la retirer manuellement du trousseau d'accès."
}
