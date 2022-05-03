#!/bin/sh

TXSER=020000000241ef3534597804d7e8730fd955b7b9b35917a78f5ea6fa45b51eaaa240351714000000006a4730440220064bfb8d50021b04df86504c85badc383828b7ca6940eece9f9c13523df891200220269531fc1f1fd94d2e8ffa46b6a71809cfe507832c0d7fb137778932cd3f609701210391e678b2299ac721d1c3a6b7f9681410f9bcdd6fe7ba0654e72b8b83dbace2f4ffffffff4f1b09e96c288db1b2fc1933da485b50ea8cc1f7407159a33e71b1c42c2ad802000000006a473044022046c1aa03e11f406abf3679bd8cdb58d0a5e3586afc701ebc7bcf5e97168b59a00220411e76eb0039c6dcc6cc811d891a4e905e0aae0454db62fa7cb5fe0725648bae01210391e678b2299ac721d1c3a6b7f9681410f9bcdd6fe7ba0654e72b8b83dbace2f4ffffffff03801a0600000000001976a91454d1395ee909e5233598fc840a03db13db6508a388ac60e31600000000001976a9140b4a4f591e63c1a6aeb1d4cc7465f887ac6c41a588ac00000000000000007f6a4c7c436f72736f20426974636f696e2068747470733a2f2f7777772e7564656d792e636f6d2f626974636f696e2d626c6f636b636861696e2d636f72736f2d636f6d706c65746f2d74656f7269612d707261746963612d6573656d70692d7475746f7269616c2f3f636f75706f6e436f64653d424c4f434b434841494e0a00000000

printf "\n Version: `printf $TXSER | cut -c 1-8` \n  \e[31m"
printf "\n #inputs: `printf $TXSER | cut -c 9-10` \n \e[34m"

printf "\n \e[33m ---------- INPUT --------- \n \e[34m"
printf "\n TXID UTXO di riferimento: `printf $TXSER | cut -c 11-74` \n \e[31m"
printf "\n vout, index della UTXO: `printf $TXSER | cut -c 75-82` \n \e[36m"
printf "\n scriptSig length (212 char hex): `printf $TXSER | cut -c 83-84` \n \e[94m"
printf "\n scriptSig: `printf $TXSER | cut -c 85-296` \n \e[32m"

printf "\n \t lunghezza signature (142 char hex): `printf $TXSER | cut -c 85-86` \n \e[33m"
printf "\n \t \t signature: `printf $TXSER | cut -c 87-228` \n \e[32m"
printf "\n \t \t \t DER Sequence: `printf $TXSER | cut -c 87-88` \n \e[31m"
printf "\n \t \t \t Lunghezza sequenza (136 char hex): `printf $TXSER | cut -c 89-90` \n \e[34m"
printf "\n \t \t \t convenzione DER: `printf $TXSER | cut -c 91-92` \n \e[92m"
printf "\n \t \t \t Lunghezza della r (64 char hex): `printf $TXSER | cut -c 93-94` \n \e[39m"
printf "\n \t \t \t r: `printf $TXSER | cut -c 95-158` \n \e[34m"
printf "\n \t \t \t convenzione DER: `printf $TXSER | cut -c 159-160` \n \e[92m"
printf "\n \t \t \t Lunghezza della s (64 char hex) : `printf $TXSER | cut -c 161-162` \n \e[39m"
printf "\n \t \t \t s: `printf $TXSER | cut -c 163-226` \n \e[91m"
printf "\n \t \t \t SIGHASH_ALL : `printf $TXSER | cut -c 227-228` \n \e[33m"
printf "\n \t Lunghezza chiave pubblica (66 char hex) : `printf $TXSER | cut -c 229-230` \n \e[93m"
printf "\n \t chiave pubblica HASH160: `printf $TXSER | cut -c 231-296`\n \e[37m"

printf "\n sequence: `printf $TXSER | cut -c 297-304` \n \e[34m"

printf "\n TXID UTXO di riferimento: `printf $TXSER | cut -c 305-368` \n \e[31m"
printf "\n vout, index della UTXO: `printf $TXSER | cut -c 369-376` \n \e[36m"
printf "\n scriptSig length (212 char hex): `printf $TXSER | cut -c 377-378` \n \e[94m"
printf "\n scriptSig: `printf $TXSER | cut -c 379-590` \n \e[32m"

printf "\n \t lunghezza signature (142 char hex): `printf $TXSER | cut -c 379-380` \n \e[33m"
printf "\n \t \t signature: `printf $TXSER | cut -c 381-522` \n \e[32m"
printf "\n \t \t \t DER Sequence: `printf $TXSER | cut -c 381-382` \n \e[31m"
printf "\n \t \t \t Lunghezza sequenza (136 char hex): `printf $TXSER | cut -c 383-384` \n \e[34m"
printf "\n \t \t \t convenzione DER: `printf $TXSER | cut -c 385-386` \n \e[92m"
printf "\n \t \t \t Lunghezza della r (64 char hex): `printf $TXSER | cut -c 387-388` \n \e[39m"
printf "\n \t \t \t r: `printf $TXSER | cut -c 389-452` \n \e[34m"
printf "\n \t \t \t convenzione DER: `printf $TXSER | cut -c 453-454` \n \e[92m"
printf "\n \t \t \t Lunghezza della s (64 char hex) : `printf $TXSER | cut -c 455-456` \n \e[39m"
printf "\n \t \t \t s: `printf $TXSER | cut -c 457-520` \n \e[91m"
printf "\n \t \t \t SIGHASH_ALL : `printf $TXSER | cut -c 521-522` \n \e[33m"
printf "\n \t Lunghezza chiave pubblica (66 char hex) : `printf $TXSER | cut -c 523-524` \n \e[93m"
printf "\n \t chiave pubblica HASH160: `printf $TXSER | cut -c 525-590`\n \e[37m"

printf "\n sequence: `printf $TXSER | cut -c 591-598` \n \e[34m"

printf "\n \e[33m ---------- fine Input --------- \n \e[37m"

printf "\n #outputs : `printf $TXSER | cut -c 599-600` \n \e[94m"

printf "\n \e[33m ---------- OUTPUT --------- \n \e[94m"

printf "\n Value in satoshi: `printf $TXSER | cut -c 601-616` \n \e[32m"
printf "\n scriptPubKey length: `printf $TXSER | cut -c 617-618` \n \e[92m"
printf "\n scriptPubKey (50 char hex): `printf $TXSER | cut -c 619-668` \n \e[31m"

printf "\n \t OP_DUP: `printf $TXSER | cut -c 619-620` \n \e[95m"
printf "\n \t OP_HASH: `printf $TXSER | cut -c 621-622` \n \e[34m"
printf "\n \t Costante (40 char hex) : `printf $TXSER | cut -c 623-624` \n \e[32m"
printf "\n \t Public key Hash160 : `printf $TXSER | cut -c 625-664` \n \e[93m"
printf "\n \t OP_EQUALVERIFY : `printf $TXSER | cut -c 665-666` \n \e[36m"
printf "\n \t OP_CHECKSIG : `printf $TXSER | cut -c 667-668` \n \e[94m"

printf "\n Value in satoshi: `printf $TXSER | cut -c 669-684` \n \e[32m"
printf "\n scriptPubKey length: `printf $TXSER | cut -c 685-686` \n \e[92m"
printf "\n scriptPubKey (50 char hex): `printf $TXSER | cut -c 687-736` \n \e[31m"

printf "\n \t OP_DUP: `printf $TXSER | cut -c 687-688` \n \e[95m"
printf "\n \t OP_HASH: `printf $TXSER | cut -c 689-690` \n \e[34m"
printf "\n \t Costante (40 char hex) : `printf $TXSER | cut -c 691-692` \n \e[32m"
printf "\n \t Public key Hash160 : `printf $TXSER | cut -c 693-732` \n \e[93m"
printf "\n \t OP_EQUALVERIFY : `printf $TXSER | cut -c 733-734` \n \e[36m"
printf "\n \t OP_CHECKSIG : `printf $TXSER | cut -c 735-736` \n \e[94m"


printf "\n Value in satoshi: `printf $TXSER | cut -c 737-752` \n \e[32m"
printf "\n scriptPubKey length: `printf $TXSER | cut -c 753-754` \n \e[92m"
printf "\n scriptPubKey (254 char hex): `printf $TXSER | cut -c 755-1008` \n \e[32m"

printf "\n \e[33m ---------- fine output --------- \n \e[37m"

printf "\n locktime : `printf $TXSER | cut -c 1009-1023` \n \e[94m"
