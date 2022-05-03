
TX=01000000029790c63c16626df5f0609a6e3c8e280e1b68c49d61b0278d324ef303f2fc4716010000008b483045022100d41329da7568547a37f947e5557d305de526ba7b71e69ead90befd126af043c9022057f994feed39228571d5c4688552fedb1a0cc5ca239dba2df023bcb28c8ac0440141047d261c1b2eef4ccba09a7266806d5f387f7726a2d835851a3ff4753c8eb51a222f7107ce2a21e5c00c7d5adca25e9eed6263b622d09f47815ca61200e7d938defffffffffd7fc597a77e94de8a6e27153f55816970833e33bd46ed1c96a8dc6fe81a311d000000008b48304502210099106bbe2177546bdc9b72749a820539d6f465ad42e33932a173e7c1f9e44ed80220026feae46a5127a5799a3c025582a5431f5d675189379bf57244569017b22be30141042b788ec363de9277bb0eb846cf42aa6b11aab224521ed656a5d3d4716c6a35270a2cceb341a3e929a36b5fe9166618079bb3cc2b203754ba57118c86235216c6ffffffff0200943577000000001976a9145c9fcd1d188f8f5ebcbb2cd8b52f11290f44d63488acc0c62d00000000001976a91413d03c357bf12bbceb49a53654b9ff32d8de955488ac00000000

printf "\n Version: `printf $TX | cut -c 1-8` \n  \e[31m"
printf "\n #inputs: `printf $TX | cut -c 9-10` \n \e[34m"

printf "\n \e[33m ---------- INPUTs --------- \n \e[34m"

printf "\n \e[33m ---------- Primo input --------- \n \e[34m"

printf "\n TXID UTXO di riferimento: `printf $TX | cut -c 11-74` \n \e[31m"
printf "\n TXID UTXO di riferimento (little endian): `printf $TX | cut -c 11-74 | tac -rs ..` \n \e[31m"
printf "\n vout, index della UTXO: `printf $TX | cut -c 75-82` \n \e[36m"

printf "\n scriptSig length: `printf $TX | cut -c 83-84` \n \e[37m"
printf "\n scriptSig length caratteri esadecimali: `expr $(echo "ibase=16; $(printf $(printf $TX | cut -c 83-84) | tr '[:lower:]' '[:upper:]')" | bc) "*" 2` \n \e[37m"

printf "\n scriptSig: `printf $TX | cut -c 85-362` \n \e[32m"
printf "\n \t lunghezza signature: `printf $TX | cut -c 85-86` \n \e[33m"
printf "\n \t lunghezza signature (caratteri esadecimali): `expr $(echo "ibase=16; $(printf $(printf $TX | cut -c 85-86) | tr '[:lower:]' '[:upper:]')" | bc) "*" 2` \n \e[37m"
printf "\n \t \t signature: `printf $TX | cut -c 87-230` \n \e[32m"
printf "\n \t \t \t DER Sequence: `printf $TX | cut -c 87-88` \n \e[31m"
printf "\n \t \t \t Lunghezza sequenza: `printf $TX | cut -c 89-90` \n \e[34m"
printf "\n \t \t \t Lunghezza sequenza (caratteri esadecimali): `expr $(echo "ibase=16; $(printf $(printf $TX | cut -c 89-90) | tr '[:lower:]' '[:upper:]')" | bc) "*" 2` \n \e[37m"
printf "\n \t \t \t convenzione DER: `printf $TX | cut -c 91-92` \n \e[92m"
printf "\n \t \t \t Lunghezza della r: `printf $TX | cut -c 93-94` \n \e[39m"
printf "\n \t \t \t Lunghezza della r (caratteri esadecimali): `expr $(echo "ibase=16; $(printf $(printf $TX | cut -c 93-94) | tr '[:lower:]' '[:upper:]')" | bc) "*" 2` \n \e[37m"
printf "\n \t \t \t r: `printf $TX | cut -c 95-160` \n \e[91m"
printf "\n \t \t \t convenzione DER: `printf $TX | cut -c 161-162` \n \e[92m"
printf "\n \t \t \t Lunghezza della s: `printf $TX | cut -c 163-164` \n \e[39m"
printf "\n \t \t \t Lunghezza della s (caratteri esadecimali): `expr $(echo "ibase=16; $(printf $(printf $TX | cut -c 163-164) | tr '[:lower:]' '[:upper:]')" | bc) "*" 2` \n \e[37m"
printf "\n \t \t \t s: `printf $TX | cut -c 165-228` \n \e[91m"
printf "\n \t \t \t SIGHASH_ALL : `printf $TX | cut -c 229-230` \n \e[33m"


printf "\n \t Lunghezza chiave pubblica : `printf $TX | cut -c 231-232` \n \e[33m"
printf "\n \t Lunghezza chiave pubblica (caratteri esadecimali): `expr $(echo "ibase=16; $(printf $(printf $TX | cut -c 231-232) | tr '[:lower:]' '[:upper:]')" | bc) "*" 2` \n \e[37m"
printf "\n \t \t chiave pubblica: `printf $TX | cut -c 233-362` \n \e[32m"
printf "\n sequence: `printf $TX | cut -c 363-370` \n \e[34m"

#––––––––––


printf "\n \e[33m ---------- Secondo  input --------- \n \e[34m"

printf "\n TXID UTXO di riferimento: `printf $TX | cut -c 372-434` \n \e[31m"
printf "\n TXID UTXO di riferimento (little endian): `printf $TX | cut -c 372-434 | tac -rs ..` \n \e[31m"
printf "\n vout, index della UTXO: `printf $TX | cut -c 435-442` \n \e[36m"

printf "\n scriptSig length: `printf $TX | cut -c 443-444` \n \e[37m"
printf "\n scriptSig length caratteri esadecimali: `expr $(echo "ibase=16; $(printf $(printf $TX | cut -c 443-444) | tr '[:lower:]' '[:upper:]')" | bc) "*" 2` \n \e[37m"

printf "\n scriptSig: `printf $TX | cut -c 445-722` \n \e[32m"
printf "\n \t lunghezza signature: `printf $TX | cut -c 445-446` \n \e[33m"
printf "\n \t lunghezza signature (caratteri esadecimali): `expr $(echo "ibase=16; $(printf $(printf $TX | cut -c 445-446) | tr '[:lower:]' '[:upper:]')" | bc) "*" 2` \n \e[37m"
printf "\n \t \t signature: `printf $TX | cut -c 447-590` \n \e[32m"

 printf "\n \t \t \t DER Sequence: `printf $TX | cut -c 447-448` \n \e[31m"
 printf "\n \t \t \t Lunghezza sequenza: `printf $TX | cut -c 449-450` \n \e[34m"
 printf "\n \t \t \t Lunghezza sequenza (caratteri esadecimali): `expr $(echo "ibase=16; $(printf $(printf $TX | cut -c 449-450) | tr '[:lower:]' '[:upper:]')" | bc) "*" 2` \n \e[37m"
 printf "\n \t \t \t convenzione DER: `printf $TX | cut -c 451-452` \n \e[92m"
 printf "\n \t \t \t Lunghezza della r: `printf $TX | cut -c 453-454` \n \e[39m"
 printf "\n \t \t \t Lunghezza della r (caratteri esadecimali): `expr $(echo "ibase=16; $(printf $(printf $TX | cut -c 453-454) | tr '[:lower:]' '[:upper:]')" | bc) "*" 2` \n \e[37m"
 printf "\n \t \t \t r: `printf $TX | cut -c 455-520` \n \e[91m"
 printf "\n \t \t \t convenzione DER: `printf $TX | cut -c 521-522` \n \e[92m"
 printf "\n \t \t \t Lunghezza della s: `printf $TX | cut -c 523-524` \n \e[39m"
 printf "\n \t \t \t Lunghezza della s (caratteri esadecimali): `expr $(echo "ibase=16; $(printf $(printf $TX | cut -c 523-524) | tr '[:lower:]' '[:upper:]')" | bc) "*" 2` \n \e[37m"
 printf "\n \t \t \t s: `printf $TX | cut -c 525-588` \n \e[91m"
 printf "\n \t \t \t SIGHASH_ALL : `printf $TX | cut -c 589-590` \n \e[33m"

 printf "\n \t Lunghezza chiave pubblica : `printf $TX | cut -c 591-592` \n \e[33m"
 printf "\n \t Lunghezza chiave pubblica (caratteri esadecimali): `expr $(echo "ibase=16; $(printf $(printf $TX | cut -c 591-592) | tr '[:lower:]' '[:upper:]')" | bc) "*" 2` \n \e[37m"
 printf "\n \t \t chiave pubblica: `printf $TX | cut -c 593-722` \n \e[32m"
 printf "\n sequence: `printf $TX | cut -c 723-730` \n \e[34m"