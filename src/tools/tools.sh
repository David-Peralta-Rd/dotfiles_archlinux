echo 'Actualizando sistema'
yay --noconfirm -Syyu

PACKAGE=(
    # Herramientas de documentacion y escritura.
    libreoffice-fresh

    # Herramientas de desarrollo
    docker
    docker-compose
    python
    uv
    visual-studio-code-bin

    # Herramientas de uso comun.
    swappy
    mpv
    wf-recorder
    firefox

)

echo 'Instalando paquetes'
yay --noconfirm -Sy "${PACKAGE[@]}"

echo '
# Distribucciont teclado
    input {
    kb_layout = es
    kb_options = escape
}

# Monitor
monitor = DP-1, 1920x1080@70, 0x0, 1

# Ejecutar varias variantes.
exec = ~/.local/lib/hyde/gamemode.sh
exec-once = ~/.local/lib/hyde/systemupdate.sh


# Velocidad de teclado.
exec-once = xset r rate 240 50

# Atajos de teclado
bind = Super+Shift, BackSpace, exec, shutdown now                           # Apagar computador.
bind = Super+Shift+Alt, BackSpace, exec, reboot                             # Reiniciar computador.
bind = Super, U, exec, ~/.local/lib/hyde/systemupdate.sh up                 # Actualizar pc sin confirmar.
' | sudo tee -a ~/.config/hypr/custom/general.conf

echo '
# Sistema.
alias c="clear"
alias t="touch"
alias mk="mkdir -p"
alias in="yay -Sy --noconfirm"
alias po="yay -Scc"

# Github.
alias gs="git status"
alias ga="git add"
alias gm="git commit -m"
alias gpl="git pull"
alias gps="git push"

# Docker.
alias dk-up="docker compose up -d"
alias dk-dw="docker compose down"
alias dk-lg="docker logs -f"
alias dk-pl="docker pull"
alias dk-clean="docker system prune"
' | sudo tee ~/.aliaszsh

echo '
source ~/.aliaszsh
' | sudo tee -a ~/.zshrc

echo ' # Configuracion.
#keep-open=yes

# Desactiva la barra de información en pantalla (OSD)
no-osd-bar

# Desactiva los atajos de teclado por defecto (puedes añadir los tuyos)
no-input-default-bindings

# Volumen al 100% (ajusta si quieres más o menos)
volume=40

# Guarda la posición de reproducción al salir (muy útil)
save-position-on-quit

# Puedes añadir más opciones aquí, por ejemplo:
#no-osc # Oculta el On-Screen Controller (el control que aparece al mover el ratón)
#quiet # Menos verbosidad en la consola
' | sudo tee ~/.config/mpv/mpv.conf
