#!/usr/bin/env bash

# =========================================================
# 🧠 Instalador automático de Zsh + Oh My Zsh + Powerlevel10k
# =========================================================
# Incluye plugins: autosuggestions, syntax highlighting, completions, zsh-autocomplete
# Autor: David (versión adaptada por GPT-5)
# =========================================================

set -e

echo "🚀 Instalando dependencias básicas..."
if command -v apt &>/dev/null; then
    sudo apt update && sudo apt install -y zsh git curl fonts-powerline
elif command -v dnf &>/dev/null; then
    sudo dnf install -y zsh git curl powerline-fonts
elif command -v pacman &>/dev/null; then
    sudo pacman -Sy --noconfirm zsh git curl powerline-fonts
else
    echo "❌ No se reconoció tu gestor de paquetes. Instala zsh, git y curl manualmente."
    exit 1
fi

echo "💾 Instalando Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    export RUNZSH=no
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "ℹ️  Oh My Zsh ya está instalado."
fi

echo "🎨 Instalando tema Powerlevel10k..."
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

echo "⚙️ Instalando plugins útiles..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

plugins_dir="$ZSH_CUSTOM/plugins"
mkdir -p "$plugins_dir"

# Plugins esenciales
declare -A plugins=(
    ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
    ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    ["zsh-completions"]="https://github.com/zsh-users/zsh-completions.git"
    ["zsh-autocomplete"]="https://github.com/marlonrichert/zsh-autocomplete.git"
)

for plugin in "${!plugins[@]}"; do
    dest="$plugins_dir/$plugin"
    if [ ! -d "$dest" ]; then
        git clone --depth=1 "${plugins[$plugin]}" "$dest"
    else
        echo "🔁 $plugin ya está instalado."
    fi
done

echo "🧩 Configurando .zshrc..."
ZSHRC="$HOME/.zshrc"

# Cambiar el tema a Powerlevel10k
sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$ZSHRC"

# Configurar plugins
sed -i 's/^plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-autocomplete)/' "$ZSHRC" || \
echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-autocomplete)' >> "$ZSHRC"

# Añadir configuración de plugins si no está presente
grep -qxF 'source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' "$ZSHRC" || echo 'source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> "$ZSHRC"
grep -qxF 'source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' "$ZSHRC" || echo 'source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> "$ZSHRC"

echo "👑 Cambiando shell predeterminado a zsh..."
chsh -s "$(which zsh)"

echo "✅ Instalación completada."
echo "💡 Reinicia tu terminal o ejecuta 'zsh' para aplicar los cambios."
echo "🧠 Cuando aparezca el asistente de Powerlevel10k, puedes personalizar el prompt a tu gusto."
echo "Copiare mi configuracion de manera predeterminada, el archivo es '.p10k.zsh'."

cp -r $PWD/.p10k.zsh ~/

echo "
#Background
background_opacity 0.75" | sudo tee -a ~/.config/kitty/kitty.conf
