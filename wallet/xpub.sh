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
printf  "\n \n ${STARTBGCOLOR}Recupero la chiave pubblica da xpub${NOCOLOR}"
printf  "\n"
xpub=xpub6Bh1dgxcWbRrreGH4t51ppX8DzUD3FS4dK3ij2aDCpfnKGbXFX964a3Uakh2e3cqg62MMpjV8d8zdjH2wq82JZhEEZMbtfnAynnfCpqT6px

xpub_raw=$(printf $xpub | base58  -d -c | xxd -p | tr -d '\n')

printf "\n \n ${MAGENTA}                      👾 DEBUG XPUB🍺  👾 ${NOCOLOR}\n"
printf " XPUB_RAW: "`printf $xpub_raw`
printf "\n VERSION BYTES PUB: "` printf $xpub_raw| cut -c 1-8`
printf "\n DEPTH : "` printf $xpub_raw | cut -c 9-10`
printf "\n FINGERPRINT : "` printf $xpub_raw | cut -c 11-18`
printf "\n CHAIN_NUMBER : "` printf $xpub_raw | cut -c 19-26`
printf "\n CHAIN CODE 0_0 : "` printf $xpub_raw | cut -c 27-90`
printf "\n Public key 0_0 : "` printf $xpub_raw | cut -c 91-156`
printf "\n \n ${MAGENTA}---------------------------------------------------${NOCOLOR}\n"

PB=$(printf $xpub_raw | tail -c 66)
CHAIN_CODE=$(printf $xpub_raw  | cut -c 27-90)

printf "child public key M => $PB \n"
printf "chain code M => $CHAIN_CODE\n"

printf "\n \n 🔑 recupero la chiave pubblica compressa di 264 bits\n"
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

# somma = parent public key + LEFT 256 BITS = child public key
PB_0=`bx ec-add $PB $LEFT_256_BITS`

# 🚫 NB: non è possibile generare child Private key, in quanto non abbiamo la parent private key 🚫

printf "\n \n 🔑 chiave pubblica compressa di 264 bits\n"
printf ${YELLOW}$PB_0${NOCOLOR};
printf "\n \n 🔑 creo l'address bitcoin \n"
PB_PUBLIC=`bx ec-to-address $PB_0`
printf ${YELLOW}$PB_PUBLIC${NOCOLOR};
printf "\n\n"

printf "\n ${MAGENTA}                      👾 DEBUG 👾 ${NOCOLOR}\n"
printf "DERIVATION => $DERIVATION \n"
printf "left 256 bit = $LEFT_256_BITS \n"
printf "child chain code (right 256 bit) = $CHAIN_0\n"
printf "parent public key + child public key =  $PB_0 \n"


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

printf "left 256 bits M/0/0 => $LEFT_256_BITS \n"
printf "child chain code M/0/0 => $CHAIN_0_0\n"

PB_0_0=`bx ec-add $PB_0 $LEFT_256_BITS`

# 🚫 NB: non è possibile generare child Private key, in quanto non abbiamo la parent private key 🚫

printf "\n \n 🔑 chiave pubblica compressa di 264 bits\n"
printf ${YELLOW}$PB_0_0${NOCOLOR};
printf "\n \n 🔑 creo l'address bitcoin \n"
PB_PUBLIC=`bx ec-to-address $PB_0_0`
printf ${YELLOW}$PB_PUBLIC${NOCOLOR};
printf "\n\n"


printf "\n ${MAGENTA}                      👾 DEBUG 👾 ${NOCOLOR}\n"
printf "DERIVATION => $DERIVATION \n"
printf "left 256 bit = $LEFT_256_BITS \n"
printf "child chain code (right 256 bit) = $CHAIN_0_0\n"
printf "parent public key + child public key =  $PB_0_0 \n"
