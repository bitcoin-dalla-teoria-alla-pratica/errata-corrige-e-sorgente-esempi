#!/bin/sh

TX=020000000241ef3534597804d7e8730fd955b7b9b35917a78f5ea6fa45b51eaaa2403517140000000000ffffffff4f1b09e96c288db1b2fc1933da485b50ea8cc1f7407159a33e71b1c42c2ad8020000000000ffffffff03801a0600000000001976a91454d1395ee909e5233598fc840a03db13db6508a388ac60e31600000000001976a9140b4a4f591e63c1a6aeb1d4cc7465f887ac6c41a588ac00000000000000007f6a4c7c436f72736f20426974636f696e2068747470733a2f2f7777772e7564656d792e636f6d2f626974636f696e2d626c6f636b636861696e2d636f72736f2d636f6d706c65746f2d74656f7269612d707261746963612d6573656d70692d7475746f7269616c2f3f636f75706f6e436f64653d424c4f434b434841494e0a00000000

printf "\n Version: `printf $TX | cut -c 1-8` \n  \e[31m"
printf "\n #inputs: `printf $TX | cut -c 9-10` \n \e[34m"

printf "\n \e[33m ---------- INPUT --------- \n \e[34m"
printf "\n TXID UTXO di riferimento: `printf $TX | cut -c 11-74` \n \e[31m"
printf "\n vout, index della UTXO: `printf $TX | cut -c 75-82` \n \e[36m"
printf "\n scriptSig length: `printf $TX | cut -c 83-84` \n \e[37m"
printf "\n sequence: `printf $TX | cut -c 85-92` \n \e[34m"
printf "\n TXID UTXO di riferimento: `printf $TX | cut -c 93-156` \n \e[31m"
printf "\n vout, index della UTXO: `printf $TX | cut -c 157-164` \n \e[36m"
printf "\n scriptSig length: `printf $TX | cut -c 165-166` \n \e[37m"
printf "\n sequence: `printf $TX | cut -c 167-174` \n \e[34m"
printf "\n \e[33m ---------- fine Input --------- \n \e[37m"

printf "\n #outputs : `printf $TX | cut -c 175-176` \n \e[94m"

printf "\n \e[33m ---------- OUTPUT --------- \n \e[94m"

printf "\n Value in satoshi: `printf $TX | cut -c 177-192` \n \e[32m"
printf "\n scriptPubKey length: `printf $TX | cut -c 193-194` \n \e[92m"
printf "\n scriptPubKey: `printf $TX | cut -c 195-244` \n \e[31m"

printf "\n \t OP_DUP: `printf $TX | cut -c 195-196` \n \e[95m"
printf "\n \t OP_HASH: `printf $TX | cut -c 197-198` \n \e[34m"
printf "\n \t Costante (40 char hex) : `printf $TX | cut -c 199-200` \n \e[32m"
printf "\n \t Public key Hash160 : `printf $TX | cut -c 201-240` \n \e[93m"
printf "\n \t OP_EQUALVERIFY : `printf $TX | cut -c 241-242` \n \e[36m"
printf "\n \t OP_CHECKSIG : `printf $TX | cut -c 243-244` \n \e[94m"

printf "\n Value in satoshi: `printf $TX | cut -c 245-260` \n \e[32m"
printf "\n scriptPubKey length: `printf $TX | cut -c 261-262` \n \e[92m"
printf "\n scriptPubKey: `printf $TX | cut -c 263-312` \n \e[31m"

printf "\n \t OP_DUP: `printf $TX | cut -c 263-264` \n \e[95m"
printf "\n \t OP_HASH: `printf $TX | cut -c 265-266` \n \e[34m"
printf "\n \t Costante (40 char hex) : `printf $TX | cut -c 267-268` \n \e[32m"
printf "\n \t Public key Hash160 : `printf $TX | cut -c 269-308` \n \e[93m"
printf "\n \t OP_EQUALVERIFY : `printf $TX | cut -c 309-310` \n \e[36m"
printf "\n \t OP_CHECKSIG : `printf $TX | cut -c 311-312` \n \e[94m"


printf "\n Value in satoshi: `printf $TX | cut -c 313-328` \n \e[32m"
printf "\n scriptPubKey length: `printf $TX | cut -c 329-330` \n \e[92m"
printf "\n scriptPubKey: `printf $TX | cut -c 331-584` \n \e[32m"

printf "\n \e[33m ---------- fine output --------- \n \e[37m"

printf "\n locktime : `printf $TX | cut -c 585-592` \n \e[94m"
