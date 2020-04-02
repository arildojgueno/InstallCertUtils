#!/bin/bash


if [ -f /usr/bin/yad ]; then
  BIN_YAD=/usr/bin/yad
elif [ -f /usr/bin/yad-real ]; then
  BIN_YAD=/usr/bin/yad-real
else
  echo "..:: Nao foi possivel iniciar o script pois o YAD nao foi encontrado ::.."
  exit 1
fi


TRUSTSTORE_FILE_PATH=$($BIN_YAD --file-selection --title "Selecione o truststore ..." --image=gtk-execute --button="gtk-ok:0" --button="gtk-cancel:1")

SENHA=$($BIN_YAD --center --title "Digite o senha" --image=gtk-execute --button="gtk-ok:0" --button="gtk-cancel:1" --form --align right --text "Senha" --field "Senha:" "")
SENHA=$(cut -d "|" -f 1 <<< "$SENHA")

clear
echo "VEJA ABAIXO QUAL O ALIAS DA ENTRADA QUE IRA DELETAR:"
sleep 2
keytool -list -v -keystore $TRUSTSTORE_FILE_PATH -storepass $SENHA




if [ -f /usr/bin/yad ]; then
  BIN_YAD=/usr/bin/yad
elif [ -f /usr/bin/yad-real ]; then
  BIN_YAD=/usr/bin/yad-real
else
  echo "..:: Nao foi possivel iniciar o script pois o YAD nao foi encontrado ::.."
  exit 1
fi

ALIAS=$($BIN_YAD --center --title "Digite o alias da entrada a ser deletada" --image=gtk-execute --button="gtk-ok:0" --button="gtk-cancel:1" --form --align right --text "Exemplo: homsegurancasinesp.serpro.gov.br-1" --field "Alias:" "")
ALIAS=$(cut -d "|" -f 1 <<< "$ALIAS")


if [ -z "$ALIAS" ]; then
  echo "..:: Ação cancelada ::.."
  exit 1
else
  clear
  echo "Deletando a entrada referente ao alias '$ALIAS' .."
fi

keytool -delete -alias $ALIAS -storepass $SENHA -keystore $TRUSTSTORE_FILE_PATH

echo ""
echo "Deletado!"
echo "Entradas existentes no truststore após a remoção: "
keytool -list -keystore $TRUSTSTORE_FILE_PATH -storepass $SENHA

