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
