VERSION_PREFIX_PB=80
VERSION_PREFIX_ADDRESS=00
    
openssl ecparam -genkey -name secp256k1 -rand /dev/urandom -out corso_priv.pem
openssl ec -in corso_priv.pem -outform DER|tail -c +8|head -c 32 |xxd -p -c 32 > corso_btc_priv.key
PK=$(printf $(cat corso_btc_priv.key))
openssl ec -in corso_priv.pem -pubout -outform DER|tail -c 65|xxd -p -c 65 > corso_btc_pub.key
PB=$(printf $(cat corso_btc_pub.key))

#Check the last byte.
U=`cat corso_btc_pub.key | cut -c 129-131`
U=`echo "$U" | tr '[:lower:]' '[:upper:]'`
U=`echo "ibase=16; $U" | bc`

if [ $(($U%2)) -eq 0 ];
then
#key even
    PREF=02
else
#key odd
    PREF=03
fi

PBC=$(cat corso_btc_pub.key | tr -d " \t\n\r"  | tail -c $((64*2)) | sed 's/.\{64\}/& /g'| awk '{print $1}'| sed -e 's/^/'$PREF/)
echo $PBC

read
ADDR_SHA=`printf $PBC | xxd -r -p | openssl sha256| sed 's/^.* //'`
printf $ADDR_SHA

read
printf "\n\n \e[45m RIPEMD160 sulla chiave pubblica \e[0m\n\n"
ADDR_RIPEMD160=`printf $ADDR_SHA |xxd -r -p | openssl ripemd160 | sed 's/^.* //'`
printf $ADDR_RIPEMD160

read
printf "\n\n \e[45m ADDRESS compresso aggiungendo l address prefix '$VERSION_PREFIX_ADDRESS'  \e[0m\n\n"
ADDR=`printf $VERSION_PREFIX_ADDRESS$ADDR_RIPEMD160 | xxd -p -r | base58 -c`
printf $ADDR

read
printf "\n\n \e[45m ADDRESS non compresso \e[0m\n\n"
ADDR_SHA=`printf $PB | xxd -r -p | openssl sha256| sed 's/^.* //'`
ADDR_RIPEMD160=`printf $ADDR_SHA |xxd -r -p | openssl ripemd160 | sed 's/^.* //'`
ADDR=`printf $VERSION_PREFIX_ADDRESS$ADDR_RIPEMD160 | xxd -p -r | base58 -c`
printf $ADDR
