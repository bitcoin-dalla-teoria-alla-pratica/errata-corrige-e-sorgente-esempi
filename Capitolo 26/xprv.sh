RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;93m"
MAGENTA="\033[1;95m"
BLU="\033[1;94m"
NOCOLOR="\033[0m"
STARTBGCOLOR="\033[44m"


# PARTENZA
# ######### DERIVATION M/44'/0'/0' #########

printf  "\n \n ${STARTBGCOLOR}######### BRANCH DA: DERIVATION M/44'/0'/0' ######### ${NOCOLOR}"
printf  "\n \n ${STARTBGCOLOR}Recupero la chiave privata da xprv${NOCOLOR}"
printf  "\n"


xprv=xprv9xhfEBRigDsZeABoxrY1TgaPfxdidniDG687veAbeV8oSUGNhypqWmizjWQp8ejMirJvQ6KxzCb3KN5sAJpeRyv4cNuq2dVbZLvPcKBTHHF

#$VERSION_BYTES_PRIV$DEPTH$FINGERPRINT$CHAIN_NUMBER$CHAIN_0_0$PADDING$PK_0_0
xprv_raw=$(printf $xprv | base58  -d -c | xxd -p | tr -d '\n')

printf "\n \n ${MAGENTA}                      👾 DEBUG XPRV  👾 ${NOCOLOR}\n"
printf " XPRV_RAW: "`printf $xprv_raw`
printf "\n VERSION BYTES PRIV: "` printf $xprv_raw| cut -c 1-8`
printf "\n DEPTH : "` printf $xprv_raw | cut -c 9-10`
printf "\n FINGERPRINT : "` printf $xprv_raw | cut -c 11-18`
printf "\n CHAIN_NUMBER : "` printf $xprv_raw | cut -c 19-26`
printf "\n CHAIN CODE 0_0 : "` printf $xprv_raw | cut -c 27-90`
printf "\n PADDING 0_0 : "` printf $xprv_raw | cut -c 91-92`
printf "\n Private key 0_0 : "` printf $xprv_raw | cut -c 93-156`
printf "\n \n ${MAGENTA}---------------------------------------------------${NOCOLOR}\n"

PK=$(printf $xprv_raw | tail -c 64)
CHAIN_CODE=$(printf $xprv_raw  | cut -c 27-90)

printf "Left 256 bits M => $PK \n"
printf "child chain code M => $CHAIN_CODE\n"

printf "\n \n 🗝 recupero la chiave privata \n"
printf ${RED}$PK${NOCOLOR};

printf "\n🗝  creo la chiave privata WIF M/0' \n"
PK_WIF=`bx ec-to-wif $PK`
printf ${RED}$PK_WIF${NOCOLOR}
printf "\n \n 🔑 creo la chiave pubblica compressa di 264 bits\n"
PB=`bx ec-to-public $PK`
printf ${YELLOW}$PB${NOCOLOR};

printf  "\n \n ${STARTBGCOLOR}######### BRANCH DA: DERIVATION M/0 ######### ${NOCOLOR}"
printf  "\n"


#Non Hardened
HARDENED_OFFSET_INDEX=00000000
DERIVATION=00
# converto 00 in esadecimale => 00, necessario per fare la somma tra esadecimali
DERIVATION_HEX=`echo "obase=16;ibase=10; $DERIVATION" | bc`
HARDENED_INDEX=`echo "obase=16;ibase=16;$HARDENED_OFFSET_INDEX+$DERIVATION_HEX" | bc| awk '{ len = (8 - length % 8) % 8; printf "%.*s%s\n", len, "00000000", $0}'`

HMAC_0=$(printf $PB$HARDENED_INDEX|xxd -r -p | openssl dgst -sha512 -hmac `printf $CHAIN_CODE |xxd -r -p` | awk '{print $2}')

LEFT_256_BITS=$(printf $HMAC_0 | head -c 64)
CHAIN_0=`printf $HMAC_0 | tail -c 64`

printf "left 256 bits M/0 => $LEFT_256_BITS \n"
printf "child chain code M/0 => $CHAIN_0\n"


# somma = parent private key + LEFT 256 BITS = child private key
PK_0=`bx ec-add-secrets $LEFT_256_BITS $PK`
printf "🗝  creo la chiave privata (child private key) m/0 \n"
printf ${RED}$PK_0${NOCOLOR}
printf "\n🗝 Private Key WIF Compressed  m/0 \n"
PK_0_WIF=`bx ec-to-wif $PK_0`
printf ${RED}$PK_0_WIF${NOCOLOR}
printf "\n \n 🔑 creo la chiave pubblica compressa di 264 bits\n"
PB_0=`bx ec-to-public $PK_0`
printf ${YELLOW}$PB_0${NOCOLOR};
printf "\n \n 🔑 creo l'address bitcoin \n"
PB_PUBLIC=`bx ec-to-address $PB_0`
printf ${YELLOW}$PB_PUBLIC${NOCOLOR};


printf "\n ${MAGENTA}                      👾 DEBUG 👾 ${NOCOLOR}\n"
printf "DERIVATION => $DERIVATION \n"
printf "Left 256 bits (left 256 bit) = $LEFT_256_BITS \n"
printf "child chain code (right 256 bit) =  $CHAIN_0\n"
printf "parent private key + LEFT 256 BITS = child private key =$PK_0 \n"
printf "Index Number =  $HARDENED_INDEX \n"

printf  "\n \n ${STARTBGCOLOR}######### BRANCH DA: DERIVATION M/0/0 ######### ${NOCOLOR}"
printf  "\n\n"


#Non Hardened
HARDENED_OFFSET_INDEX=00000000
DERIVATION=00
# converto 00 in esadecimale => 00, necessario per fare la somma tra esadecimali
DERIVATION_HEX=`echo "obase=16;ibase=10; $DERIVATION" | bc`
HARDENED_INDEX=`echo "obase=16;ibase=16;$HARDENED_OFFSET_INDEX+$DERIVATION_HEX" | bc| awk '{ len = (8 - length % 8) % 8; printf "%.*s%s\n", len, "00000000", $0}'`


HMAC_0_0=$(printf $PB_0$HARDENED_INDEX|xxd -r -p | openssl dgst -sha512 -hmac `printf $CHAIN_0 |xxd -r -p` | awk '{print $2}')

LEFT_256_BITS=`printf $HMAC_0_0 | head -c 64`
CHAIN_0_0=`printf $HMAC_0_0 | tail -c 64`

printf "left 256 bits M/00 => $LEFT_256_BITS \n"
printf "child chain code M/0/0 => $CHAIN_0_0\n"


# somma = parent private key + LEFT 256 BITS = child private key
PK_0_0=`bx ec-add-secrets $LEFT_256_BITS $PK_0`
printf "🗝  creo la chiave privata (child private key) m/0/0 \n"
printf ${RED}$PK_0_0${NOCOLOR}
printf "\n🗝 Private Key WIF Compressed  m/0/0 \n"
PK_0_0_WIF=`bx ec-to-wif $PK_0_0`
printf ${RED}$PK_0_0_WIF${NOCOLOR}
printf "\n \n 🔑 creo la chiave pubblica compressa di 264 bits\n"
PB_0_0=`bx ec-to-public $PK_0_0`
printf ${YELLOW}$PB_0_0${NOCOLOR};
printf "\n \n 🔑 creo l'address bitcoin \n"
PB_PUBLIC=`bx ec-to-address $PB_0_0`
printf ${YELLOW}$PB_PUBLIC${NOCOLOR};


printf "\n ${MAGENTA}                      👾 DEBUG 👾 ${NOCOLOR}\n"
printf "DERIVATION => $DERIVATION \n"
printf "Left 256 bits (left 256 bit) = $PK_0_0_LEFT \n"
printf "child chain code (right 256 bit) =  $CHAIN_0_0\n"
printf "parent private key + LEFT 256 BITS = child private key =$PK_0_0 \n"
printf "Index Number =  $HARDENED_INDEX \n"
