#!/bin/bash

LAST_TRUSTSTORE_SELECTED_FILEPATH="/tmp/last_truststore_selected.tmp"
if [ -f "$LAST_TRUSTSTORE_SELECTED_FILEPATH" ] ; then 
  LAST_TRUSTORE_SELECTED=`cat $LAST_TRUSTSTORE_SELECTED_FILEPATH`
fi

if [ -f /usr/bin/yad ]; then
  BIN_YAD=/usr/bin/yad
elif [ -f /usr/bin/yad-real ]; then
  BIN_YAD=/usr/bin/yad-real
else
  echo "..:: Nao foi possivel iniciar o script pois o YAD nao foi encontrado ::.."
  exit 1
fi


if [ -f "$LAST_TRUSTORE_SELECTED" ] ; then 
  TRUSTSTORE_FILE_PATH=$($BIN_YAD --file-selection --filename=$LAST_TRUSTORE_SELECTED --title "Selecione o truststore ...." --image=gtk-execute --button="gtk-ok:0" --button="gtk-cancel:1")

  if [ -f "$TRUSTSTORE_FILE_PATH" ] ; then 
     echo $TRUSTSTORE_FILE_PATH > $LAST_TRUSTSTORE_SELECTED_FILEPATH
  fi
else
  TRUSTSTORE_FILE_PATH=$($BIN_YAD --file-selection --title "Selecione o truststore ...." --image=gtk-execute --button="gtk-ok:0" --button="gtk-cancel:1")
fi


SENHA=$($BIN_YAD --center --title "Digite o senha" --image=gtk-execute --button="gtk-ok:0" --button="gtk-cancel:1" --form --align right --text "Senha" --field "Senha:" "")
SENHA=$(cut -d "|" -f 1 <<< "$SENHA")

keytool $1 -list -keystore $TRUSTSTORE_FILE_PATH -storepass $SENHA
