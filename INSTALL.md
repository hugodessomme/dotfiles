# Configuration de Mac pour développeur

Inspiré du [guide de Robin Wieruch](https://www.robinwieruch.de/mac-setup-web-development/), adapté à mes préférences

## Sommaire

- [Réglages système](#réglages-système)
- [Finder](#finder)
- [Homebrew](#homebrew)
- [iTerm2](#iterm2)
- [Oh My Zsh](#oh-my-zsh)
- [Git](#git)
- [NVM pour Node/npm](#nvm-pour-nodenpm)
- [SSH](#ssh)
- [AltTab](#alttab)
- [Brave Browser](#brave-browser)
- [Hidden Bar](#hidden-bar)
- [Raycast](#raycast)
- [VSCode](#vscode)

## Réglages système

**Général** → AirDrop et Continuité → AirDrop : `Contacts uniquement`

**Apparence** → Mode d'apparence : `Sombre`

**Accessibilité** → Contrôle du pointeur → Options du trackpad → Vitesse de défilement : `Niveau 6`

**Bureau et Dock**

- Dock
  - Réduire la taille du Dock
  - Animation de réduction des fenêtres : `Effet d'échelle`
  - Minimiser les fenêtres dans l'icône de l'application : `Activé`
  - Masquer et afficher automatiquement le Dock : `Activé`
  - Animer les applications lors de leur ouverture : `Désactivé`
  - Afficher les apps suggérées et récentes dans le Dock : `Désactivé`
- Bureau et Stage Manager
  - Désactiver tous les éléments du bureau
  - Cliquer sur le fond d'écran pour afficher le bureau : `Uniquement dans Stage Manager`
- Widgets : Désactiver tous les widgets
- Fenêtres
  - Fermer les fenêtres à la fermeture d'une application : `Désactivé`
  - Coins actifs : `Tout désactiver`

**Moniteurs**

- Régler automatiquement la luminosité : `Désactivé`
- True Tone : `Désactivé`
- Lors de la connexion à un téléviseur : `Utiliser en tant qu'affichage étendu`
- Night Shift
  - Programme : `Personnalisé (21:30 → 07:00)`
  - Température des couleurs : `Plus chaudes`

**Fond d'écran** → Couleur : `Noir`

**Spotlight**

- Afficher le contenu associé : `Désactivé`
- Aider Apple à améliorer la recherche : `Désactivé`

**Notifications** : Désactiver les notifications de toutes les applications

**Son**

- Volume d'alerte : `50 %`
- Émettre un son au démarrage : `Désactivé`

**Écran verrouillé**

- Éteindre l'écran sur batterie en cas d'inactivité : `5 minutes`
- Éteindre l'écran sur adaptateur secteur en cas d'inactivité : `Jamais`

**Confidentialité et sécurité** → FileVault : `Activé`

**Game Center** : Désactiver Game Center

**Clavier**

- Luminosité du clavier : `Désactivée`
- Appuyer sur la touche Globe pour : `Ne rien faire`
- Méthodes de saisie
  - Mettre automatiquement en majuscule la première lettre des mots : `Désactivé`
  - Ajouter un point en saisissant deux espaces : `Désactivé`
  - Guillemets doubles : `“abc”`
  - Guillemets simples : `‘abc’`
  - Ajouter la langue : `Russe`
- Dictée : `Activée`

**Trackpad**

- Pointer et cliquer
  - Vitesse de déplacement : `Niveau 6`
  - Clic forcé et retour tactile : `Désactivé`
  - Recherche et détecteurs de données : `Désactivé`
  - Clic secondaire : `Cliquer dans le coin inférieur droit`
  - Toucher pour cliquer : `Activé`
- Faire défiler et zoomer → Défilement naturel : `Désactivé`
- Gestes supplémentaires → Mission Control : `Désactivé`

**Réglages complémentaires**

- Supprimer toutes les applications du Dock sauf : `Finder`, `Réglages système`, `Corbeille`

- Renommer la machine :

```bash
sudo scutil --set ComputerName "newname"
sudo scutil --set LocalHostName "newname"
sudo scutil --set HostName "newname"
```

- Appliquer les préférences système suivantes :

```bash
# captures d'écran en JPG
defaults write com.apple.screencapture type jpg

# ne pas rouvrir les anciens fichiers dans Aperçu
defaults write com.apple.Preview ApplePersistenceIgnoreState YES

# afficher le dossier Bibliothèque
chflags nohidden ~/Library

# afficher les fichiers cachés
defaults write com.apple.finder AppleShowAllFiles YES

# afficher la barre du chemin
defaults write com.apple.finder ShowPathbar -bool true

# afficher la barre d'état
defaults write com.apple.finder ShowStatusBar -bool true

killall Finder
```

## Finder

**Général**

- Afficher ces éléments sur le bureau : `Tout désactiver`
- Les nouvelles fenêtres du Finder affichent : `Nom d'utilisateur`

**Tags** : Désactiver tous les tags

**Barre latérale**

- Conserver uniquement : `Applications`, `Bureau`, `Documents`, `Téléchargements`, `Nom d'utilisateur`
- Déplacer le dossier utilisateur dans **Favoris**

**Options avancées**

- Avertir avant de modifier une extension : `Désactivé`
- Supprimer les éléments de la corbeille après 30 jours : `Activé`
- En effectuant une recherche : `Rechercher dans le dossier actuel`

## Homebrew

- Installer Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- Mettre à jour

```bash
brew update
```

- Installer les applications graphiques

```bash
brew install --cask \
  alt-tab \
  brave-browser \
  claude-code \
  codex \
  font-hack-nerd-font \
  hiddenbar \
  iterm2 \
  raycast \
  visual-studio-code \
  vlc
```

- Installer les outils en ligne de commande

```bash
brew install \
  docker \
  docker-compose \
  gh \
  git \
  glab \
  jq \
  nvm \
  shfmt \
  starship
```

## iTerm2

**iTerm2** : `Make iTerm2 Default Term`

**Settings**

- General
  - Closing
    - Quit when all windows are closed : `Activé`
    - Confirm closing multiple sessions : `Désactivé`
    - Confirm "Quit iTerm2" : `Désactivé`
  - Window → Native full screen windows : `Désactivé`
- Appearance
  - Windows → Hide scrollbars : `Activé`
  - Dimming : Désactiver toutes les options
- Profiles
  - General → Initial Directory → Advanced Configuration : `Reuse previous session's directory`
  - Text
    - Font : `Hack Nerd Font Mono`
    - Taille : `16 px`
  - Window → New Windows → Screen : `Main Screen`
  - Terminal → Show mark indicators : `Désactivé`
  - Keys → Key Bindings → Presets : `Natural Text Editing`
  - Advanced → Semantic History : `Open with editor`, `VS Code`

## Oh My Zsh

- Installer Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- Mettre à jour

```bash
omz update
```

- Copier le `.zshrc` et `aliases.zsh`

```bash
curl -fsSL https://raw.githubusercontent.com/hugodessomme/dotfiles/main/zsh/.zshrc -o ~/.zshrc
curl -fsSL https://raw.githubusercontent.com/hugodessomme/dotfiles/main/zsh/aliases.zsh -o ~/.oh-my-zsh/custom/aliases.zsh
```

- Installer les plugins

```bash
# zsh-completions
git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

- Recharger la configuration Zsh

```bash
source ~/.zshrc
```

**Alias disponibles**

```bash
# lister tous les alias (hors fonctions)
alias

# afficher le fichier des alias personnalisés
cat ~/.oh-my-zsh/custom/aliases.zsh
```

## Git

Définir les informations globales

```bash
git config --global user.name "<nom>"
git config --global user.email "<email>"
git config --global init.defaultBranch main
```

## NVM pour Node/npm

- Installer la dernière version LTS de Node.js

```bash
nvm install --lts
```

- Définir les informations utilisées par `npm init`

```bash
npm config set init-author-name "<nom>"
npm config set init-author-email "<email>"
npm config set init-author-url "<site-web>"
```

## SSH

Créer une clé SSH pour chaque service (ex : github)

```bash
sshn
gh auth login # à adapter par service
```

## AltTab

**Apparence**

- Taille : `Petite`
- Personnaliser davantage
  - Masquer les icônes d'état : `Activé`
  - Masquer les numéros de Bureau : `Activé`
  - Masquer les cercles colorés au survol de la souris : `Activé`
  - Afficher les titres : `Nom de l'application`

**Contrôles** → Raccourci 1 → Déclencheur : `Command + Tab`

**Général** → Icône de la barre des menus : `Sur fond blanc`

## Brave Browser

**Paramètres**

- Premiers pas → Personnaliser la page de nouvel onglet
  - Image de fond → Afficher les images d'arrière-plan : `Désactivé`
  - Rechercher → Afficher le widget du moteur de recherche dans les nouveaux onglets : `Désactivé`
  - Mes sites → Favoris : `Activé`
  - Horloge → Afficher l'horloge : `Activé`
  - Modules : `Désactivé`
- Apparence
  - Personnaliser votre barre d'outils → Avancer : `Activé`
  - Afficher la barre de favoris : `Toujours`
  - Afficher les groupes d'onglets dans la barre de favoris : `Désactivé`
  - Afficher les suggestions semi-automatiques dans la barre d'adresse
    - Suggestions sur l'appareil : `Activé`
    - Historique de navigation : `Activé`
    - Favoris : `Activé`
  - Utiliser une barre d'adresse large : `Activé`
  - Toujours afficher la barre d'outils en plein écran : `Désactivé`
  - Afficher des coins arrondis dans les principales zones de contenu : `Activé`
  - Mode de survol des onglets : `Info-bulle`
  - Afficher l'utilisation de la mémoire dans l'aperçu au survol de l'onglet : `Désactivé`
  - Afficher la barre latérale : `Afficher à gauche`
- Contenu → Afficher l'invite Wayback Machine sur les pages 404 : `Désactivé`
- Boucliers → Autoriser les connexions Facebook et les publications intégrées : `Désactivé`
- Leo
  - Afficher l'icône Leo dans la barre latérale : `Désactivé`
  - Afficher Leo dans le menu contextuel sur les sites Web : `Désactivé`
  - Mode Focus : `Désactivé`
  - Conserver l'historique des conversations : `Désactivé`
- Moteur de recherche
  - Fenêtre normale : `Google`
  - Fenêtre de navigation privée : `Google`
  - Améliorer les suggestions de recherche : `Désactivé`
- Extensions
  - Media Router : `Désactivé`
  - Widevine : `Activé`
- Langues → Utiliser Brave Traduction : `Désactivé`
- Téléchargements
  - Toujours demander où enregistrer les fichiers : `Désactivé`
  - Afficher les téléchargements une fois qu'ils sont terminés : `Désactivé`
- Système
  - Afficher un rappel en plein écran indiquant d'appuyer sur Esc pour quitter : `Désactivé`
  - Économiseur de mémoire : `Activé`

## Hidden Bar

**Réglages**

- Démarrer automatiquement Hidden Bar lors de la connexion : `Activé`
- Afficher les réglages au lancement : `Désactivé`
- Déplacer les icônes de la barre de menu à masquer

## Raycast

**Réglages système** → Clavier → Raccourcis clavier → Spotlight : `Désactivé`

**Extensions** → Hotkey

- Brave Browser : `Option + B`
- Visual Studio Code : `Option + C`
- iTerm2 : `Option + T`

**Create Quicklink**

- `caniuse` : `https://caniuse.com/?search={argument}`
- `google` : `https://google.com/search?q={argument}`
- `mdn` : `https://developer.mozilla.org/fr/search?q={argument}`
- `npm` : `https://www.npmjs.com/search?q={argument}`
- `reddit` : `https://www.reddit.com/search/?q={argument}`

**Create Snippet**

- `@imaddr` : `<adresse-postale>`
- `@imemail` : `<email>`
- `@imtel` : `<numero-telephone>`

## VSCode

- Créer les dossiers dédiés au code

```bash
mkdir -p \
  ~/Code \
  ~/Code/_devtools-overrides \
  ~/Code/_pro \
  ~/Code/_tmp \
  ~/Code/_workspaces
```

- Installer les extensions

```bash
code \
  --install-extension anthropic.claude-code \
  --install-extension bradlc.vscode-tailwindcss \
  --install-extension dbaeumer.vscode-eslint \
  --install-extension editorconfig.editorconfig \
  --install-extension esbenp.prettier-vscode \
  --install-extension maosantaella.night-wolf \
  --install-extension mikestead.dotenv \
  --install-extension mkhl.shfmt \
  --install-extension naumovs.color-highlight \
  --install-extension openai.chatgpt \
  --install-extension sibiraj-s.vscode-scss-formatter \
  --install-extension stylelint.vscode-stylelint \
  --install-extension unifiedjs.vscode-mdx \
  --install-extension vincaslt.highlight-matching-tag \
  --install-extension yoavbls.pretty-ts-errors
```

- Copier le `settings.json`

```bash
curl -fsSL https://raw.githubusercontent.com/hugodessomme/dotfiles/main/vscode/settings.json -o ~/Library/Application\ Support/Code/User/settings.json
```
