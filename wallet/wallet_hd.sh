
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;93m"
MAGENTA="\033[1;95m"
BLU="\033[1;94m"
NOCOLOR="\033[0m"
STARTBGCOLOR="\033[44m"


#mnemonic che viene passata al codice php
PASS="accident dizzy shrimp topple swift weekend slice space when pistol comic grid"
echo "Mnemonic phrase:${BLU}$PASS${NOCOLOR} \n"
RES=`php root_seed.php $PASS`
echo "🌱 Root Seed:${MAGENTA}$RES${NOCOLOR}"

printf  "\n ${STARTBGCOLOR}######### CREO LA MASTER PRIVATE KEY  #########${NOCOLOR}\n\n"

RES0=`printf $RES|xxd -r -p | openssl dgst -sha512 -hmac "Bitcoin seed" | awk '{print $2}'`

PK_M_LEFT=`printf $RES0 | head -c 64`
CHAIN=`printf $RES0 | tail -c 64`
printf "child private key (privata master) (left 256 bit) => $PK_M_LEFT \n"
printf "child chain code (right 256 bit )    => $CHAIN \n\n "

printf "🗝  Chiave privata master \n"
printf ${RED}$PK_M_LEFT${NOCOLOR}
printf "\n \n 🔑 creo la chiave pubblica master compressa di 264 bits\n"
MASTER_PB=`bx ec-to-public $PK_M_LEFT`
printf ${YELLOW}$MASTER_PB${NOCOLOR}"\n\n";

#COSTANTE PER TUTTI I PASSAGGI
VERSION_BYTES_PRIV=0488ADE4

DEPTH=00
FINGERPRINT=00000000
CHAIN_NUMBER=00000000
PADDING=00
XPRV=`printf $VERSION_BYTES_PRIV$DEPTH$FINGERPRINT$CHAIN_NUMBER$CHAIN$PADDING$PK_M_LEFT`
XPRV=`printf $XPRV | xxd -p -r | base58 -c`
echo "🎋 BIP32 Root Key:${BLU}$XPRV${NOCOLOR} \n"

#COSTANTE PER TUTTI I PASSAGGI
VERSION_BYTES_PUB=0488B21E

#A differenza della xprv: Cambio la version byte ed elimino il padding, e utilizzo la chiave pubblica a 256 bits
XPUB=`printf $VERSION_BYTES_PUB$DEPTH$FINGERPRINT$CHAIN_NUMBER$CHAIN$MASTER_PB`
XPUB=`printf $XPUB | xxd -p -r | base58 -c`
echo "🎋 BIP32 Root Public Key:${YELLOW}$XPUB${NOCOLOR} \n"

printf "\n \n ${MAGENTA}                      👾 DEBUG 👾 ${NOCOLOR}\n"
printf "MASTER PRIVATE KEY = $PK_M_LEFT \n"
printf "MASTER PUBLIC KEY = $MASTER_PB \n"
printf "CHAIN CODE = $CHAIN"

#
# ###############################################################
#
echo  "\n \n ${STARTBGCOLOR}######### DERIVATION M/44' #########${NOCOLOR}"
printf "\n\n"

#Padding come da documentazione
#COSTANTE PER TUTTI I PASSAGGI
HARDENED_CHILD_PAD=00

#purpose da bip 44
# 80000000  Hardened
HARDENED_OFFSET_INDEX=80000000
#purpose
DERIVATION=44
##converto 44 in esadecimale => 2C, necessario per fare la somma tra esadecimali
DERIVATION_HEX=`echo "obase=16;ibase=10; $DERIVATION" | bc`
#Somma 2147483692 e converto in hex 8000002C
HARDENED_INDEX=`echo "obase=16;ibase=16;$HARDENED_OFFSET_INDEX+$DERIVATION_HEX" | bc| awk '{ len = (8 - length % 8) % 8; printf "%.*s%s\n", len, "00000000", $0}'`


#Concatenazione dei componenti e metto come key la parent Chain code
HMAC_44=$(printf $HARDENED_CHILD_PAD$PK_M_LEFT$HARDENED_INDEX|xxd -r -p | openssl dgst -sha512 -hmac `printf $CHAIN |xxd -r -p` | awk '{print $2}')

LEFT_256_BITS=`printf $HMAC_44 | head -c 64`
CHAIN_44=`printf $HMAC_44 | tail -c 64`

# somma = parent private key + LEFT 256 BITS = child private key
PK_44=`bx ec-add-secrets $PK_M_LEFT $LEFT_256_BITS`

printf "🗝  creo la chiave privata (child private key) m/44' \n"
printf ${RED}$PK_44${NOCOLOR}
printf "\n🗝 Private Key WIF Compressed m/44' \n"
PK_44_WIF=`bx ec-to-wif $PK_44`
printf ${RED}$PK_44_WIF${NOCOLOR}
printf "\n \n 🔑 creo la chiave pubblica compressa di 264 bits\n"
PB_44=`bx ec-to-public $PK_44`
printf ${YELLOW}$PB_44${NOCOLOR};
printf "\n \n 🔑 creo l'address bitcoin \n"
PB_PUBLIC=`bx ec-to-address $PB_44`
printf ${YELLOW}$PB_PUBLIC${NOCOLOR};


#Per verificare su ian coleman, inserire m/44' nella derivation path BIP32 e togliere la spunta
#xprv
DEPTH=01
# FINGERPRINT DELLA CHIAVE PRECENDENTE,sono i primi 8 caratteri della chiave pubblica precedente in formato HASH160
SHA256=`printf $MASTER_PB | xxd -r -p | openssl sha256 | awk '{print $2}'`
FINGERPRINT=`printf $SHA256 | xxd -r -p | openssl ripemd160 | awk '{print $2}' | head -c 8`
CHAIN_NUMBER=$HARDENED_INDEX
PADDING=00
XPRV=`printf $VERSION_BYTES_PRIV$DEPTH$FINGERPRINT$CHAIN_NUMBER$CHAIN_44$PADDING$PK_44`
XPRV=`printf $XPRV | xxd -p -r | base58 -c`
echo "\n \n🎋 Extended Private Key:${BLU}$XPRV${NOCOLOR} \n"

#xpub
#A differenza della xprv:  Cambio la version byte ed elimino il padding, e utilizzo la chiave pubblica a 256 bits
XPUB=`printf $VERSION_BYTES_PUB$DEPTH$FINGERPRINT$CHAIN_NUMBER$CHAIN_44$PB_44`
XPUB=`printf $XPUB | xxd -p -r | base58 -c`
echo "🎋 Extended Public Key:${YELLOW}$XPUB${NOCOLOR} \n"

printf "\n ${MAGENTA}                      👾 DEBUG 👾 ${NOCOLOR}\n"
printf "DERIVATION => $DERIVATION \n"
printf "left 256 bit = $LEFT_256_BITS \n"
printf "child chain code (right 256 bit) =  $CHAIN_44\n"
printf "parent private key + LEFT 256 BITS = child private key = $PK_44 \n"
printf "Chiave pubblica compressa derivata  =  $PB_44 \n"
printf "Index Number =  $HARDENED_INDEX \n"


#
# ###############################################################
#

printf  "\n${STARTBGCOLOR}######### DERIVATION M/44'/0' #########${NOCOLOR}"
printf  "\n\n"

#per verificalo su iancoleman, inserire m/44' e spuntare Use Hardened
# 80000000  Hardened
HARDENED_OFFSET_INDEX=80000000
#coin_type'
DERIVATION=00
# Superfluo, viene mantenuto solo per coerenza
# converto 00 in esadecimale => 00, necessario per fare la somma tra esadecimali
DERIVATION_HEX=`echo "obase=16;ibase=10; $DERIVATION" | bc`
HARDENED_INDEX=`echo "obase=16;ibase=16;$HARDENED_OFFSET_INDEX+$DERIVATION_HEX" | bc| awk '{ len = (8 - length % 8) % 8; printf "%.*s%s\n", len, "00000000", $0}'`

#Concatenazione dei componenti e metto come key la parent Chain code
HMAC_0=$(printf $HARDENED_CHILD_PAD$PK_44$HARDENED_INDEX|xxd -r -p | openssl dgst -sha512 -hmac `printf $CHAIN_44 |xxd -r -p` | awk '{print $2}')

LEFT_256_BITS=`printf $HMAC_0 | head -c 64`
CHAIN_0=`printf $HMAC_0 | tail -c 64`
printf "left 256 bits  44'/0' => $LEFT_256_BITS \n"
printf "child chain code 44'/0' => $CHAIN_0\n"

# somma = parent private key + LEFT 256 BITS = child private key
PK_0=`bx ec-add-secrets $LEFT_256_BITS $PK_44`

printf "🗝  creo la chiave privata (child private key) m/44'/0' \n"
printf ${RED}$PK_0${NOCOLOR}
printf "\n🗝 Private Key WIF Compressed m/44'/0' \n"
PK_0_WIF=`bx ec-to-wif $PK_0`
printf ${RED}$PK_0_WIF${NOCOLOR}
printf "\n \n 🔑 creo la chiave pubblica compressa di 264 bits\n"
PB_0=`bx ec-to-public $PK_0`
printf ${YELLOW}$PB_0${NOCOLOR};
printf "\n \n 🔑 creo l'address bitcoin \n"
PB_PUBLIC=`bx ec-to-address $PB_0`
printf ${YELLOW}$PB_PUBLIC${NOCOLOR};


#Per verificare su ian coleman, inserire m/44'/0' nella derivation path BIP32 e togliere la spunta
#xprv
DEPTH=02
# FINGERPRINT DELLA CHIAVE PRECENDENTE,sono i primi 8 caratteri della chiave pubblica precedente in formato HASH160
SHA256=`printf $PB_44 | xxd -r -p | openssl sha256 | awk '{print $2}'`
FINGERPRINT=`printf $SHA256 | xxd -r -p | openssl ripemd160 | awk '{print $2}' | head -c 8`
CHAIN_NUMBER=$HARDENED_INDEX
PADDING=00
XPRV=`printf $VERSION_BYTES_PRIV$DEPTH$FINGERPRINT$CHAIN_NUMBER$CHAIN_0$PADDING$PK_0`
XPRV=`printf $XPRV | xxd -p -r | base58 -c`
echo "\n \n🎋 Extended Private Key:${BLU}$XPRV${NOCOLOR} \n"

#xpub

#A differenza della xprv:  Cambio la version byte ed elimino il padding, e utilizzo la chiave pubblica a 256 bits
XPUB=`printf $VERSION_BYTES_PUB$DEPTH$FINGERPRINT$CHAIN_NUMBER$CHAIN_0$PB_0`
XPUB=`printf $XPUB | xxd -p -r | base58 -c`
echo "\n🎋 Extended Public Key:${YELLOW}$XPUB${NOCOLOR} \n"


printf "\n \n ${MAGENTA}                      👾 DEBUG 👾 ${NOCOLOR}\n"
printf "DERIVATION => $DERIVATION \n"
printf "left 256 bit = $LEFT_256_BITS \n"
printf "child chain code (right 256 bit) = $CHAIN_0\n"
printf "parent private key + LEFT 256 BITS = child private key = $PK_0 \n"
printf "Chiave pubblica compressa derivata  =  $PB_0 \n"
printf "Index Number =  $HARDENED_INDEX \n"


#
# ###############################################################
#

#per verificalo su iancoleman, inserire m/44'/0' e spuntare Use Hardened

printf  "${STARTBGCOLOR}######### DERIVATION M/44'/0'/0' ######### ${NOCOLOR}"
printf  "\n\n"

# account' 80000000  Hardened
HARDENED_OFFSET_INDEX=80000000
#account'
DERIVATION=00
# Superfluo, viene mantenuto solo per coerenza
# converto 00 in esadecimale => 00, necessario per fare la somma tra esadecimali
DERIVATION_HEX=`echo "obase=16;ibase=10; $DERIVATION" | bc`
HARDENED_INDEX=`echo "obase=16;ibase=16;$HARDENED_OFFSET_INDEX+$DERIVATION_HEX" | bc| awk '{ len = (8 - length % 8) % 8; printf "%.*s%s\n", len, "00000000", $0}'`


HMAC_0_0=$(printf $HARDENED_CHILD_PAD$PK_0$HARDENED_INDEX|xxd -r -p | openssl dgst -sha512 -hmac `printf $CHAIN_0 |xxd -r -p` | awk '{print $2}')

LEFT_256_BITS=`printf $HMAC_0_0 | head -c 64`
CHAIN_0_0=`printf $HMAC_0_0 | tail -c 64`
printf "left 256 bits 44'/0'/0' => $LEFT_256_BITS \n"
printf "child chain code 44'/0'/0' => $CHAIN_0_0\n"

# somma = parent private key + LEFT 256 BITS = child private key
PK_0_0=`bx ec-add-secrets $LEFT_256_BITS $PK_0`

printf "🗝  creo la chiave privata (child private key) m/44'/0'/0' \n"
printf ${RED}$PK_0_0${NOCOLOR}
printf "\n🗝 Private Key WIF Compressed m/44'/0'/0' \n"
PK_0_0_WIF=`bx ec-to-wif $PK_0_0`
printf ${RED}$PK_0_0_WIF${NOCOLOR}
printf "\n \n 🔑 creo la chiave pubblica compressa di 264 bits\n"
PB_0_0=`bx ec-to-public $PK_0_0`
printf ${YELLOW}$PB_0_0${NOCOLOR};
printf "\n \n 🔑 creo l'address bitcoin \n"
PB_PUBLIC=`bx ec-to-address $PB_0_0`
printf ${YELLOW}$PB_PUBLIC${NOCOLOR};

#Per verificare su ian coleman, inserire m/44'/0'/0' nella derivation path BIP32 e togliere la spunta
# Visibili anche in BIP44
#xprv
DEPTH=03
# FINGERPRINT DELLA CHIAVE PRECENDENTE,sono i primi 8 caratteri della chiave pubblica precedente in formato HASH160
SHA256=`printf $PB_0 | xxd -r -p | openssl sha256 | awk '{print $2}'`
FINGERPRINT=`printf $SHA256 | xxd -r -p | openssl ripemd160 | awk '{print $2}' | head -c 8`
CHAIN_NUMBER=$HARDENED_INDEX
PADDING=00
XPRV=`printf $VERSION_BYTES_PRIV$DEPTH$FINGERPRINT$CHAIN_NUMBER$CHAIN_0_0$PADDING$PK_0_0`
XPRV=`printf $XPRV | xxd -p -r | base58 -c`
echo "\n \n🎋 Extended Private Key:${BLU}$XPRV${NOCOLOR} \n"

#xpub
#A differenza della xprv:  Cambio la version byte ed elimino il padding, e utilizzo la chiave pubblica a 256 bits
XPUB=`printf $VERSION_BYTES_PUB$DEPTH$FINGERPRINT$CHAIN_NUMBER$CHAIN_0_0$PB_0_0`
XPUB=`printf $XPUB | xxd -p -r | base58 -c`
echo "\n🎋 Extended Public Key:${YELLOW}$XPUB${NOCOLOR} \n"

printf "\n \n ${MAGENTA}                      👾 DEBUG 👾 ${NOCOLOR}\n"
printf "DERIVATION => $DERIVATION \n"
printf "left 256 bit =$LEFT_256_BITS \n"
printf "child chain code (right 256 bit) =$CHAIN_0_0\n"
printf "parent private key + LEFT 256 BITS = child private key = $PK_0_0 \n"
printf "Chiave pubblica compressa derivata  =  $PB_0_0 \n"
printf "Index Number =  $HARDENED_INDEX \n"

##############################################################
# Derivazione NON Hardened: Nella funzione HMAC NON C'E' PADDING E USO LA PARENT PUBLIC KEY INVECE CHE LA PARENT PRIVATE KEY
#per verificalo su iancoleman, inserire m/44'/0'/0' e non spuntare Use Hardened

printf  "\n \n ${STARTBGCOLOR}######### DERIVATION M/44'/0'/0'/0 ######### ${NOCOLOR}"
printf  "\n \n"

#Non Hardened, change
HARDENED_OFFSET_INDEX=00000000
DERIVATION=00
# converto 00 in esadecimale => 00, necessario per fare la somma tra esadecimali
DERIVATION_HEX=`echo "obase=16;ibase=10; $DERIVATION" | bc`
HARDENED_INDEX=`echo "obase=16;ibase=16;$HARDENED_OFFSET_INDEX+$DERIVATION_HEX" | bc| awk '{ len = (8 - length % 8) % 8; printf "%.*s%s\n", len, "00000000", $0}'`

HMAC_0_0_0=$(printf $PB_0_0$HARDENED_INDEX|xxd -r -p | openssl dgst -sha512 -hmac `printf $CHAIN_0_0 |xxd -r -p` | awk '{print $2}')

LEFT_256_BITS=`printf $HMAC_0_0_0 | head -c 64`
CHAIN_0_0_0=`printf $HMAC_0_0_0 | tail -c 64`
printf "left 256 bits 44'/0'/0'/0 => $LEFT_256_BITS \n"
printf "child chain code 44'/0'/0'/0 => $CHAIN_0_0_0\n"

# somma = parent private key + LEFT 256 BITS = child private key
PK_0_0_0=`bx ec-add-secrets $LEFT_256_BITS $PK_0_0`
printf "🗝  creo la chiave privata (child private key) m/44'/0'/0'/0 \n"
printf ${RED}$PK_0_0_0${NOCOLOR}
printf "\n🗝 Private Key WIF Compressed m/44'/0'/0'/0 \n"
PK_0_0_0_WIF=`bx ec-to-wif $PK_0_0_0`
printf ${RED}$PK_0_0_0_WIF${NOCOLOR}
printf "\n \n 🔑 creo la chiave pubblica compressa di 264 bits\n"
PB_0_0_0=`bx ec-to-public $PK_0_0_0`
printf ${YELLOW}$PB_0_0_0${NOCOLOR};
printf "\n \n 🔑 creo l'address bitcoin \n"
PB_PUBLIC=`bx ec-to-address $PB_0_0_0`
printf ${YELLOW}$PB_PUBLIC${NOCOLOR};

#Per verificare su ian coleman, inserire m/44'/0'/0'/0 nella derivation path BIP32 e togliere la spunta
# È il primo risultato del BIP44
#xprv
DEPTH=04
# FINGERPRINT DELLA CHIAVE PRECENDENTE,sono i primi 8 caratteri della chiave pubblica precedente in formato HASH160
SHA256=`printf $PB_0_0 | xxd -r -p | openssl sha256 | awk '{print $2}'`
FINGERPRINT=`printf $SHA256 | xxd -r -p | openssl ripemd160 | awk '{print $2}' | head -c 8`
CHAIN_NUMBER=$HARDENED_INDEX
PADDING=00
XPRV=`printf $VERSION_BYTES_PRIV$DEPTH$FINGERPRINT$CHAIN_NUMBER$CHAIN_0_0_0$PADDING$PK_0_0_0`
XPRV=`printf $XPRV | xxd -p -r | base58 -c`
echo "\n \n🎋 Extended Private Key:${BLU}$XPRV${NOCOLOR} \n"

#xpub
#A differenza della xprv:  Cambio la version byte ed elimino il padding, e utilizzo la chiave pubblica a 256 bits
XPUB=`printf $VERSION_BYTES_PUB$DEPTH$FINGERPRINT$CHAIN_NUMBER$CHAIN_0_0_0$PB_0_0_0`
XPUB=`printf $XPUB | xxd -p -r | base58 -c`
echo "\n🎋 Extended Public Key:${YELLOW}$XPUB${NOCOLOR} \n"

printf "\n \n ${MAGENTA}                      👾 DEBUG 👾 ${NOCOLOR}\n"
# printf "DERIVATION => $DERIVATION \n"
printf "left 256 bit =$LEFT_256_BITS \n"
printf "child chain code (right 256 bit) =$CHAIN_0_0_0\n"
printf "parent private key + LEFT 256 BITS = child private key = $PK_0_0_0 \n"
printf "Chiave pubblica compressa derivata  =  $PB_0_0_0 \n"
printf "Index Number =  $HARDENED_INDEX \n"

##############################################################
# Derivazione NON Hardened: Nella funzione HMAC NON C'E' PADDING E USO LA PARENT PUBLIC KEY INVECE CHE LA PARENT PRIVATE KEY
#per verificalo su iancoleman, inserire m/44'/0'/0'/0 e non spuntare Use Hardened
# È il primo risultato del BIP44
printf  "\n \n ${STARTBGCOLOR}######### DERIVATION M/44'/0'/0'/0/0 #########${NOCOLOR}"
printf " \n \n"

#Non Hardened, address_index
HARDENED_OFFSET_INDEX=00000000
DERIVATION=00
# converto 00 in esadecimale => 00, necessario per fare la somma tra esadecimali
DERIVATION_HEX=`echo "obase=16;ibase=10; $DERIVATION" | bc`
HARDENED_INDEX=`echo "obase=16;ibase=16;$HARDENED_OFFSET_INDEX+$DERIVATION_HEX" | bc| awk '{ len = (8 - length % 8) % 8; printf "%.*s%s\n", len, "00000000", $0}'`


#INIZIO A FARE HMAC CON PB
HMAC_0_0_0_0=$(printf $PB_0_0_0$HARDENED_INDEX|xxd -r -p | openssl dgst -sha512 -hmac `printf $CHAIN_0_0_0 |xxd -r -p` | awk '{print $2}')

LEFT_256_BITS=`printf $HMAC_0_0_0_0 | head -c 64`
CHAIN_0_0_0_0=`printf $HMAC_0_0_0_0 | tail -c 64`
printf "left 256 bits 44'/0'/0'/0/0 => $LEFT_256_BITS \n"
printf "child chain code 44'/0'/0'/0/0 => $CHAIN_0_0_0_0\n"

# somma = parent private key + LEFT 256 BITS = child private key
PK_0_0_0_0=`bx ec-add-secrets $LEFT_256_BITS $PK_0_0_0`
#
printf "🗝  creo la chiave privata (child private key) m/44'/0'/0'/0/0 \n"
printf ${RED}$PK_0_0_0_0${NOCOLOR}
printf "\n🗝 Private Key WIF Compressed m/44'/0'/0'/0/0 \n"
PK_0_0_0_0_WIF=`bx ec-to-wif $PK_0_0_0_0`
printf ${RED}$PK_0_0_0_0_WIF${NOCOLOR}
printf "\n \n 🔑 creo la chiave pubblica compressa di 264 bits\n"
PB_0_0_0_0=`bx ec-to-public $PK_0_0_0_0`
printf ${YELLOW}$PB_0_0_0_0${NOCOLOR};
printf "\n \n 🔑 creo l'address bitcoin \n"
PB_PUBLIC=`bx ec-to-address $PB_0_0_0_0`
printf ${YELLOW}$PB_PUBLIC${NOCOLOR};

#Per verificare su ian coleman, inserire m/44'/0'/0'/0/0 nella derivation path BIP32 e togliere la spunta
#xprv
DEPTH=05
# FINGERPRINT DELLA CHIAVE PRECENDENTE,sono i primi 8 caratteri della chiave pubblica precedente in formato HASH160
SHA256=`printf $PB_0_0_0 | xxd -r -p | openssl sha256 | awk '{print $2}'`
FINGERPRINT=`printf $SHA256 | xxd -r -p | openssl ripemd160 | awk '{print $2}' | head -c 8`
CHAIN_NUMBER=$HARDENED_INDEX
PADDING=00
XPRV=`printf $VERSION_BYTES_PRIV$DEPTH$FINGERPRINT$CHAIN_NUMBER$CHAIN_0_0_0_0$PADDING$PK_0_0_0_0`
XPRV=`printf $XPRV | xxd -p -r | base58 -c`
echo "\n \n🎋 Extended Private Key:${BLU}$XPRV${NOCOLOR} \n"

#xpub

#A differenza della xprv:  Cambio la version byte ed elimino il padding, e utilizzo la chiave pubblica a 256 bits
XPUB=`printf $VERSION_BYTES_PUB$DEPTH$FINGERPRINT$CHAIN_NUMBER$CHAIN_0_0_0_0$PB_0_0_0_0`
XPUB=`printf $XPUB | xxd -p -r | base58 -c`
echo "\n🎋 Extended Public Key:${YELLOW}$XPUB${NOCOLOR} \n"


printf "\n \n ${MAGENTA}                      👾 DEBUG 👾 ${NOCOLOR}\n"
printf "DERIVATION => $DERIVATION \n"
printf "left 256 bit = $LEFT_256_BITS \n"
printf "child chain code (right 256 bit) = $CHAIN_0_0_0_0\n"
printf "parent private key + LEFT 256 BITS = child private key = $PK_0_0_0_0 \n"
printf "Chiave pubblica compressa derivata  =  $PB_0_0_0_0 \n"
printf "Index Number =  "$HARDENED_INDEX" \n"
