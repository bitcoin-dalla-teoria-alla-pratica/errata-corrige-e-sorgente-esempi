OHASH=000000000000000049a0914d83df36982c77ac1f65ade6a52bdced2ce312aba9
ver=`printf 00000002 | tac -rs ..| tr -d '\n'`
prev=`printf 000000000000000082ccf8f1557c5d40b21edabb18d2d691cfbf87118bac7254 | tac -rs .. | tr -d '\n'`
mkl=`printf 7cbbf3148fe2407123ae248c2de7428fa067066baee245159bf4a37c37aa0aab | tac -rs .. | tr -d '\n'`
time=`printf '%x\n' 1399704683 | tac -rs .. | tr -d '\n'`
bits=`echo 1900896c | tac -rs .. | tr -d '\n'`
nonce=`printf '%x\n' 3476871405 | tac -rs .. | tr -d '\n'`

printf "\n\n \e[45m I valori Concatenati \e[0m\n\n"
CONC=$ver$prev$mkl$time$bits$nonce
printf $CONC

read;
printf "\n\n \e[45m Applicare lo SHA256 per due volte \e[0m\n\n"
RES=$(printf $CONC | xxd -r -p | sha256sum -b | xxd -r -p | sha256sum -b)
printf $RES

read;
printf "\n\n \e[45m Giriamo l'ordine dei bytes \e[0m\n\n"
HASH=$(printf $RES | tac -rs ..)
printf $HASH

read;
printf "\n\n \e[45m Verifichiamo i due HASH. HASH ottenuto e HASH del blocco 300001 \e[0m\n\n"
test $HASH = $OHASH  && echo sono uguali || echo sono diversi

read;
printf "\n\n \e[45m Target da battere \e[0m\n\n"
TARGET=$(echo "obase=10; ibase=16; -u; $(echo 0000000000000896c00000000000000000000000000000000000000000000 | tr '[:lower:]' '[:upper:]')" |bc | sed -n 2p)
echo $TARGET

read;
printf "\n\n \e[45m HASH trovato in base 10 \e[0m\n\n"
HBASE10=$(echo "obase=10; ibase=16; -u; $(echo $HASH | tr '[:lower:]' '[:upper:]')" |bc | sed -n 2p)
printf $HBASE10

read;
printf "\n\n \e[45m sottraiamo il risultato del target da battere con il risultato hash ottenuto \e[0m\n\n"
bc <<< "$HBASE10 - $TARGET"
