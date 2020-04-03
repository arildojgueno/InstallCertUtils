#!/bin/bash

JAVA_CMD=`which java`

if [ -f /usr/bin/yad ]; then
  BIN_YAD=/usr/bin/yad
elif [ -f /usr/bin/yad-real ]; then
  BIN_YAD=/usr/bin/yad-real
else
  echo "..:: Nao foi possivel iniciar o script pois o YAD nao foi encontrado ::.."
  exit 1
fi

DNS=$($BIN_YAD --center --title "Digite o DNS" --image=gtk-execute --button="gtk-ok:0" --button="gtk-cancel:1" --form --align right --text "Exemplo: para 'https://xpto.test.com/api/v3', seria 'xpto.test.com'" --field "DNS:" "")
DNS=$(cut -d "|" -f 1 <<< "$DNS")


if [ -z "$DNS" ]; then
  echo "..:: Ação cancelada ::.."
  exit 1
else
  echo "..:: $DNS ::.."
fi

if [ -e "$LAST_TRUSTORE_SELECTED" ] ; then 
  TRUSTSTORE_FILE_PATH=$($BIN_YAD --file-selection --filename=$LAST_TRUSTORE_SELECTED --title "Selecione o truststore ...." --image=gtk-execute --button="gtk-ok:0" --button="gtk-cancel:1")

  LAST_TRUSTORE_SELECTED=$TRUSTSTORE_FILE_PATH
else
  TRUSTSTORE_FILE_PATH=$($BIN_YAD --file-selection --title "Selecione o truststore ...." --image=gtk-execute --button="gtk-ok:0" --button="gtk-cancel:1")
fi



SENHA=$($BIN_YAD --center --title "Digite o senha" --image=gtk-execute --button="gtk-ok:0" --button="gtk-cancel:1" --form --align right --text "Senha" --field "Senha:" "")
SENHA=$(cut -d "|" -f 1 <<< "$SENHA")


echo  "java InstallALLCerts $DNS $TRUSTSTORE_FILE_PATH changeit"
if [ -e "$TRUSTSTORE_FILE_PATH" ] ; then 

   $JAVA_CMD InstallALLCerts $DNS "$TRUSTSTORE_FILE_PATH" $SENHA $1

else 
  echo "..:: O arquivo $TRUSTSTORE_FILE_PATH não existe! ::.."
  exit 1
fi



