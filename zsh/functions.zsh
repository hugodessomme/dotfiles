# met à jour les refs et supprime les branches locales retirées du remote
gfp() {
    git fetch --prune
    git for-each-ref --format='%(refname:short) %(upstream:track)' refs/heads \
        | grep '\[gone\]' \
        | awk '{print $1}' \
        | while IFS= read -r branch; do
            git branch -D "$branch"
        done
}

# bascule sur la branche principale, pull (rebase), met à jour les refs et supprime les branches locales retirées du remote
gswm() {
    git switch $(git_main_branch)
    gpr
    gfp
}

# créé une merge request
gmr() {
  if [[ $# -lt 2 ]]; then
    echo "Usage: gmr <type> <slug-description> [jira-id]"
    return 0
  fi

  local template_path=".gitlab/merge_request_templates/Default.md"

  local type="$1"
  local slug_description="$2"
  local jira_id="$3"

  local branch="${type}/${slug_description}"
  [[ -n "$jira_id" ]] && branch="${branch}-${jira_id}"

  gswc "$branch" || return 1
  gp -u origin "$branch" || return 1

  local mr_description
  mr_description=$(
    {
      [[ -n "$jira_id" ]] && echo "Closes JIRA#STUDIOD-${jira_id}"
      echo
      [[ -f "$template_path" ]] && cat "$template_path"
    }
  )

  local target_branch="$(git_main_branch)"

  glab mr create \
    --assignee @me \
    --description "$mr_description" \
    --draft \
    --no-editor \
    --remove-source-branch \
    --target-branch "$target_branch" \
    --title "$branch" \
    --yes
}

# créé une clé SSH
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

  cat >> "$HOME/.ssh/config" <<EOF

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

  pbcopy < "$key.pub"
  echo
  echo "La clé '$name' a bien été ajoutée et copiée dans le presse-papier."
}

# liste et copie une clé SSH
sshg() {
  local name="$1"

  if [[ -n "$name" && -f "$HOME/.ssh/$name.pub" ]]; then
    pbcopy < "$HOME/.ssh/$name.pub"
    echo "La clé '$name' a bien été copiée dans le presse-papier."
    return 0
  fi

  echo "Clés SSH existantes :"
  echo
  for key in "$HOME"/.ssh/*.pub; do
    [[ -f "$key" ]] || continue
    basename "$key" .pub
  done
}

# supprime une clé SSH
sshrm() {
  local name="$1"
  local key="$HOME/.ssh/$name"

  if [[ -z "$name" || ! -f "$key.pub" ]]; then
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
