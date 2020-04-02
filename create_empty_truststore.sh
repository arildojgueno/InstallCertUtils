#!/bin/bash

if [ -f /usr/bin/yad ]; then
  BIN_YAD=/usr/bin/yad
elif [ -f /usr/bin/yad-real ]; then
  BIN_YAD=/usr/bin/yad-real
else
  echo "..:: Nao foi possivel iniciar o script pois o YAD nao foi encontrado ::.."
  exit 1
fi


TRUSTSTORE_FILENAME="emptyTruststore.jks"

SENHA=$($BIN_YAD --center --title "Digite o senha" --image=gtk-execute --button="gtk-ok:0" --button="gtk-cancel:1" --form --align right --text "Senha" --field "Senha:" "")
SENHA=$(cut -d "|" -f 1 <<< "$SENHA")

echo "Criando truststore conforme abaixo"
echo "Nome do arquivo: $TRUSTSTORE_FILENAME"
LOCAL_ATUAL=`pwd`
echo "Localização: $LOCAL_ATUAL"
echo "Senha: $SENHA"
sleep 2

# Primeiro vai criar com 1 entrada dentro
keytool -genkeypair -alias boguscert -storepass $SENHA -keypass $SENHA -keystore $TRUSTSTORE_FILENAME -dname "CN=Developer, OU=Department, O=Company, L=City, ST=State, C=CA"
# Depois deleta a entrada
keytool -delete -alias boguscert -storepass $SENHA -keystore $TRUSTSTORE_FILENAME

echo ""
echo ""
echo ""
echo ""
echo "Listando conteudo da truststore criada"
keytool -list -keystore $TRUSTSTORE_FILENAME -storepass $SENHA
