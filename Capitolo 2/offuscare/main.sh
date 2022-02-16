#!/bin/sh

#clean
rm -rf Alice
rm -rf Bob


#Creo le cartelle
## -p, --parents
 ## no error if existing, make parent directories as needed
printf '\e[32mPer prima cosa creiamo delle cartelle\e[0m\n\n'
read
sed -n 1,2p main.txt
mkdir -p Alice
mkdir -p Bob
read
printf '\e[32mspostiamoci dentro la cartella di alice\e[0m\n\n'
read
sed -n 3p main.txt
cd Alice

read
printf "\n\n \e[105m ######### Creo la chiave privata di Alice (privata_alice.pem) #########\e[0m\n\n"
read
sed -n 4p ../main.txt
read
openssl genrsa -out privata_alice.pem 2048
read

printf "\n\n \e[105m ######### Derivo la chiave pubblica (pubblica_alice.pem) di Alice dalla chiave privata  #########\e[0m\n\n"
read
sed -n 5p ../main.txt
read
openssl rsa -in privata_alice.pem -outform PEM -pubout -out pubblica_alice.pem

printf "\n\e[32m ######### 👾 DEBUG chiave privata #########\e[0m\n\n"
printf '\e[31m\n- Che comando potrei usare? 👨🏻‍🎓\e[0m\n\n'
read
sed -n 6p ../main.txt
read
cat privata_alice.pem
read

printf "\n\e[32m ######### 👾 DEBUG chiave pubblica #########\e[0m\n\n"
read
sed -n 7p ../main.txt
read
cat pubblica_alice.pem
read

printf "\n\e[32m ######### mandiamo la chiave pubblica di Alice a Bob, il quale la utilizzerà per crittografare il messaggio #########\e[0m\n\n"
read
sed -n 8p ../main.txt
read
cp pubblica_alice.pem ../Bob && cd ../Bob
read

printf "\n\n \e[101m Bob Crea il messaggio.txt \e[0m\n\n"
read
sed -n 9p ../main.txt
read
echo "W Bitcoin" >> messaggio.txt
read

printf "\n\e[32m ######### 👾 DEBUG cat messaggio.txt #########\e[0m\n\n"
read
sed -n 10p ../main.txt
read
cat messaggio.txt
read

printf "\n\n \e[101m Bob offusca il messaggio con la chiave pubblica di Alice \e[0m\n\n"
read
sed -n 11p ../main.txt
read
cat messaggio.txt | openssl rsautl -encrypt -pubin -inkey pubblica_alice.pem > messaggio_crittato.txt
read

printf "\n\e[32m ######### 👾 DEBUG messaggio_crittato.txt #########\e[0m\n\n"
read
sed -n 12p ../main.txt
read
cat messaggio_crittato.txt
read

printf "\n\e[32m ######### 👾 HEX version #########\e[0m\n\n"
read
sed -n 13p ../main.txt
read
hexdump -C messaggio_crittato.txt
read

printf "\n\n \e[101m Bob manda il messaggio ad Alice \e[0m\n\n"
read
sed -n 14p ../main.txt
read
mv messaggio_crittato.txt ../Alice && cd ../Alice
read

printf "\n\n \e[105m ######### Alice usa la sua chiave privata per leggere il messaggio in chiaro #########\e[0m\n\n"
read
sed -n 15,16p ../main.txt
read
cat messaggio_crittato.txt | openssl rsautl -decrypt -inkey privata_alice.pem > messaggio_decrittato.txt
cat messaggio_decrittato.txt
