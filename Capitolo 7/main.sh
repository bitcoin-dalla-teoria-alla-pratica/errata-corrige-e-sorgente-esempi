PROOF=0100000050120119172a610421a6c3011dd330d9df07b63616c2cc1f1cd00200000000006657a9252aacd5c0b2940996ecff952228c3067cc38d4885efb5a4ac4247e9f337221b4d4c86041b0f2b5710040000000315b88c5107195bf09eb9da89b83d95b3d070079a3c5c5d3d17d0dcd873fbdaccc46e239ab7d28e2c019b6d66ad8fae98a56ef1f21aeecb94d1b1718186f059631d0cb83721529a062d9675b98d6e5c587e4a770fc84ed00abc5a5de04568a6e9010d
MERKLEROOT=f3e94742aca4b5ef85488dc37c06c3282295ffec960994b2c0d5ac2a25a95766

printf "\n\n \e[45m Version Hex \e[0m\n\n"
VERSIONHEX=$(printf $PROOF | cut -c 1-8)
printf $VERSIONHEX

printf "\n\npremi un tasto per continuare";
read;

printf "\n\n \e[45m previous block hash \e[0m\n\n"
PREVIOUS_BLOCK_HASH=$(printf $PROOF  | cut -c 9-72)
printf $PREVIOUS_BLOCK_HASH

read;
printf "\n\n \e[45m Merkle root \e[0m\n\n"
PROOF_MERKLE_ROOT=$(printf $PROOF  | cut -c 73-136)
printf $PROOF_MERKLE_ROOT
# PROOF_MERKLE_ROOT=$(printf $PROOF  | cut -c 73-136 | tac -rs ..)
# printf $PROOF  | cut -c 73-136

# read;
# printf "\n\n \e[45m confronto il merkle root ottenuto con quello del blocco \e[0m\n\n"
# test  $PROOF_MERKLE_ROOT = $MERKLEROOT && echo sono uguali || echo sono diversi

read;
printf "\n\n \e[45m time \e[0m\n\n"
TIME=$(printf $PROOF | cut -c 137-144)
printf $TIME

# read;
# printf "\n\n \e[45m time convertito in base 10 \e[0m\n\n"
# echo "ibase=16; $(printf $(printf $TIME | tac -rs ..)  | tr '[:lower:]' '[:upper:]')" | bc

read;
printf "\n\n \e[45m bits \e[0m\n\n"
BITS=$(printf $PROOF | cut -c 145-152)
printf $BITS

# read;
# printf "\n\n \e[45m bits in little endian \e[0m\n\n"
# printf $BITS | tac -rs ..

read;
printf "\n\n \e[45m nonce \e[0m\n\n"
NONCE=$(printf $PROOF | cut -c 153-160)
printf $NONCE

# printf "\n\n \e[45m nonce base10 e big endian \e[0m\n\n"
# echo "ibase=16; $(printf $(printf $NONCE | tac -rs ..)  | tr '[:lower:]' '[:upper:]')" | bc

read;
printf "\n\n \e[45m Unendo i valori appena analizzati ottengo l'hash del blocco \e[0m\n\n"
printf $(printf $VERSIONHEX$PREVIOUS_BLOCK_HASH$PROOF_MERKLE_ROOT$TIME$BITS$NONCE | xxd -r -p | sha256sum -b | xxd -r -p | sha256sum -b) | tac -rs ..

read;
printf "\n\n \e[44m Inizio merkleblock message \e[0m\n\n"

read;
printf "\n\n \e[45m numero delle transazione \e[0m\n\n"
NTX=$(printf $PROOF | cut -c 161-168)
printf $NTX


read;
printf "\n\n \e[45m numero Foglie \e[0m\n\n"
FOGLIE=$(printf $PROOF | cut -c 169-170)
printf $FOGLIE

read;
printf "\n\n \e[45m TX1 \e[0m\n\n"
TX1=$(printf $PROOF | cut -c 171-234)
printf $TX1

read;
printf "\n\n \e[45m TX2 \e[0m\n\n"
TX2=$(printf $PROOF | cut -c 235-298)
printf $TX2


read;
printf "\n\n \e[45m TX3 \e[0m\n\n"
TX3=$(printf $PROOF | cut -c 299-362)
printf $TX3


read;
printf "\n\n \e[45m flag byte count \e[0m\n\n"
FLAG_COUNT=$(printf $PROOF | cut -c 363-364)
printf $FLAG_COUNT


read;
printf "\n\n \e[45m flag byte count \e[0m\n\n"
FLAG=$(printf $PROOF | cut -c 365-366)
printf $FLAG
