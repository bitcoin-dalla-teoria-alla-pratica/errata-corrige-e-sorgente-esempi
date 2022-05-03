VERSION_PREFIX_ADDRESS=00

printf "\n\n \e[41m Analizziamo l input della transazione 3446bb5b86fa410d6c8676b0f93e665d06d4a18c97c7d0f2d80460d9696b2325\e[0m\n\n"
sleep 5

printf "\n\n \e[41m Di seguito la sua transaction data\e[0m\n\n"
TX_DATA=01000000029790c63c16626df5f0609a6e3c8e280e1b68c49d61b0278d324ef303f2fc4716010000008b483045022100d41329da7568547a37f947e5557d305de526ba7b71e69ead90befd126af043c9022057f994feed39228571d5c4688552fedb1a0cc5ca239dba2df023bcb28c8ac0440141047d261c1b2eef4ccba09a7266806d5f387f7726a2d835851a3ff4753c8eb51a222f7107ce2a21e5c00c7d5adca25e9eed6263b622d09f47815ca61200e7d938defffffffffd7fc597a77e94de8a6e27153f55816970833e33bd46ed1c96a8dc6fe81a311d000000008b48304502210099106bbe2177546bdc9b72749a820539d6f465ad42e33932a173e7c1f9e44ed80220026feae46a5127a5799a3c025582a5431f5d675189379bf57244569017b22be30141042b788ec363de9277bb0eb846cf42aa6b11aab224521ed656a5d3d4716c6a35270a2cceb341a3e929a36b5fe9166618079bb3cc2b203754ba57118c86235216c6ffffffff0200943577000000001976a9145c9fcd1d188f8f5ebcbb2cd8b52f11290f44d63488acc0c62d00000000001976a91413d03c357bf12bbceb49a53654b9ff32d8de955488ac00000000
echo $TX_DATA
sleep 5

printf "\n\n \e[41m esadecimale 48 ci indica di prendere 144 caratteri successivi. Convertiamolo in base 10\e[0m\n\n"
expr `echo "ibase=16; $(printf 48 | tr '[:lower:]' '[:upper:]')" | bc` "*" 2
sleep 5

printf "\n\n \e[41m I 144 caratteri esadeciamli successivi a 48 rappresenta la signature dello scriptsig:\e[0m\n\n"
SIG=$(printf $TX_DATA | cut -c 87-230)
printf $SIG
sleep 5

printf "\n\n \e[41m esadecimale 41 ci indica di prendere 130 caratteri successivi. Convertiamolo in base 10\e[0m\n\n"
expr `echo "ibase=16; $(printf 41 | tr '[:lower:]' '[:upper:]')" | bc` "*" 2

sleep 5
printf "\n\n \e[41m I 130 caratteri esadeciamli successivi a 41 rappresenta la chiave pubblica:\e[0m\n\n"
PB=$(printf $TX_DATA | cut -c 233-362)
printf $PB
sleep 5

printf "\n\n \e[41m Otteniamo la rappresentazione HASH160 (SHA256 e RIPEMD160) della chiave pubblica.\e[0m\n\n"

ADDR_SHA=`printf $PB | xxd -r -p | openssl sha256| sed 's/^.* //'`
ADDR_RIPEMD160=`printf $ADDR_SHA |xxd -r -p | openssl ripemd160 | sed 's/^.* //'`
printf $ADDR_RIPEMD160
sleep 5

printf "\n\n \e[41m Applichiamo quindi il base58check aggiungendo il prefisso della mainnet ($VERSION_PREFIX_ADDRESS).\e[0m\n\n"
ADDR=$(printf $VERSION_PREFIX_ADDRESS$ADDR_RIPEMD160  | xxd -p -r | base58 -c)
echo $ADDR