#!/bin/sh

MERKLEROOT=f3e94742aca4b5ef85488dc37c06c3282295ffec960994b2c0d5ac2a25a95766

TX1=8c14f0db3df150123e6f3dbbf30f8b955a8249b62ac1d1ff16284aefa3d06d87
TX2=fff2525b8931402dd09222c50775608f75787bd2b87e56995a7bdd30f79702c4
TX3=6359f0868171b1d194cbee1af2f16ea598ae8fad666d9b012c8ed2b79a236ec4
TX4=e9a66845e05d5abc0ad04ec80f774a7e585c6e8db975962d069a522137b80c1d

TX1LITTLE=$(printf $TX1 | tac -rs ..)
TX2LITTLE=$(printf $TX2 | tac -rs ..)
TX3LITTLE=$(printf $TX3 | tac -rs ..)
TX4LITTLE=$(printf $TX4 | tac -rs ..)


printf "\n\n \e[45m TX1 little endian \e[0m\n\n"
printf $TX1LITTLE

printf "\n\npremi un tasto per continuare";
read;

printf "\n\n \e[45m TX2 little endian \e[0m\n\n"
printf $TX2LITTLE

printf "\n\npremi un tasto per continuare";
read;

printf "\n\n \e[45m TX3 little endian \e[0m\n\n"
printf $TX3LITTLE

printf "\n\npremi un tasto per continuare";
read;

printf "\n\n \e[45m TX4 little endian \e[0m\n\n"
printf $TX4LITTLE

printf "\n\npremi un tasto per continuare";
read;

printf "\n\n \e[45m Unisco la TX1 e la TX2 e applico lo SHA256 per due volte (Hab) \e[0m\n\n"
HAB=$(printf $TX1LITTLE+$TX2LITTLE | xxd -r -p | sha256sum -b | xxd -r -p | sha256sum -b | awk '{print $1}')
printf $HAB

printf "\n\npremi un tasto per continuare";
read;

printf "\n\n \e[45m Unisco la TX3 e la TX4 e applico lo SHA256 per due volte (Hcd) \e[0m\n\n"
HCD=$(printf $TX3LITTLE+$TX4LITTLE | xxd -r -p | sha256sum -b | xxd -r -p | sha256sum -b | awk '{print $1}')
printf $HCD

printf "\n\npremi un tasto per continuare";
read;

printf "\n\n \e[45m Unisco la Hab e Hcd e applico lo SHA256 per due volte (Habcd) \e[0m\n\n"
HABCD=$(printf $HAB+$HCD | xxd -r -p | sha256sum -b | xxd -r -p | sha256sum -b | awk '{print $1}')
printf $HABCD

printf "\n\npremi un tasto per continuare";
read;

printf "\n\n \e[45m Converto in Big Endian \e[0m\n\n"
RES=$(printf $HABCD | tac -rs ..)
printf $RES

printf "\n\npremi un tasto per continuare";
read;

printf "\n\n \e[45m Verifico se il risultato combacia con il merkle root \e[0m\n\n"
test $RES = $MERKLEROOT && echo sono uguali || echo sono diversi