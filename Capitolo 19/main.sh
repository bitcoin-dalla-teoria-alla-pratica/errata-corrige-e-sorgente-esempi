VERSION_PREFIX=80
WIF_SUFFIX=01

printf "\n\n \e[45m CREO LA CHIAVE PRIVATA e la salvo in corso_priv.pem \e[0m\n\n"
openssl ecparam -genkey -name secp256k1 -rand /dev/urandom -out corso_priv.pem
cat corso_priv.pem

read
printf "\n\n \e[45m Genero la chiave privata di 32 bytes per Bitcoin e la salvo in corso_btc_priv.key\e[0m\n\n"
openssl ec -in corso_priv.pem -outform DER|tail -c +8|head -c 32 |xxd -p -c 32 > corso_btc_priv.key
cat corso_btc_priv.key
PK=$(printf $(cat corso_btc_priv.key))

read
printf "\n\n \e[45m Formato base64 \e[0m\n\n"
printf $PK |xxd -r -p |  base64

read
printf "\n\n \e[45m Chiave privata WIF \e[0m\n\n"
WIF=$(printf $VERSION_PREFIX$PK | xxd -r -p | base58 -c)
printf $WIF

read
printf "\n\n \e[45m Chiave privata WIF compressa \e[0m\n\n"
WIFC=$(printf $VERSION_PREFIX$PK$WIF_SUFFIX | xxd -r -p | base58 -c)
printf $WIFC