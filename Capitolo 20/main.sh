printf "\n\n \e[45m CREO LA CHIAVE PRIVATA e la salvo in corso_priv.pem \e[0m\n\n"
openssl ecparam -genkey -name secp256k1 -rand /dev/urandom -out corso_priv.pem
cat corso_priv.pem

read
printf "\n\n \e[45m Genero la chiave privata di 32 bytes per Bitcoin e la salvo in corso_btc_priv.key\e[0m\n\n"
openssl ec -in corso_priv.pem -outform DER|tail -c +8|head -c 32 |xxd -p -c 32 > corso_btc_priv.key
cat corso_btc_priv.key
PK=$(printf $(cat corso_btc_priv.key))

read
printf "\n\n \e[45m CREO LA CHIAVE Pubblica \e[0m\n\n"
openssl ec -in corso_priv.pem -pubout -outform DER|tail -c 65|xxd -p -c 65 > corso_btc_pub.key

PB=$(printf $(cat corso_btc_pub.key))
printf $PB


read
printf "\n\n \e[45m Lunghezza Caratteri Chiave Pubbica \e[0m\n\n"
printf $PB | wc -c



read
printf "\n\n \e[45m Ottengo la X e la Y \e[0m\n\n"
printf $PB| tail -c $((64*2)) | sed 's/.\{64\}/& /g'| tr " " "\n"


#Check the last byte.
U=`cat corso_btc_pub.key | cut -c 129-131`
U=`echo "$U" | tr '[:lower:]' '[:upper:]'`
U=`echo "ibase=16; $U" | bc`

read
printf "\n\n \e[45m verifico se l'ultimo byte è pari o dispari \e[0m\n\n" 
cat corso_btc_pub.key | cut -c 129-131

read
printf "\n\n \e[45m l ultimo byte converito in base 10 \e[0m\n\n" 
printf $U

if [ $(($U%2)) -eq 0 ];
then
#key even
    PREF=02
printf "\nIl numero e' pari"    
else
#key odd
    PREF=03
    printf "\nIl numero e' dispari" 
fi

read
printf "\n \n 🔑 Creo la chiave pubblica compressa key \n"
cat corso_btc_pub.key | tr -d " \t\n\r"  | tail -c $((64*2)) | sed 's/.\{64\}/& /g'| awk '{print $1}'| sed -e 's/^/'$PREF/ 

