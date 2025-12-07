echo "Instalando dotfiles end_4"
bash <(curl -s https://ii.clsty.link/get)

echo "Ejecutamos instalacion de zsh y estilo."
bash $PWD/src/zsh/install_zsh.sh

echo "Instalamos programas"
bash $PWD/src/tools/tools.sh

echo "Configuramos programas"
bash $PWD/src/tools/configuration.sh
