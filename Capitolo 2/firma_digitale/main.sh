#!/bin/sh

#clean
rm -rf Alice
rm -rf Bob


#Creo le cartelle
## -p, --parents
 ## no error if existing, make parent directories as needed
printf '\e[32mCreiamo due cartelle, Alice e Bob, e spostiamoci all interno di Alice\e[0m\n\n'
read
sed -n 1,3p main.txt
read
mkdir -p Alice
mkdir -p Bob
cd Alice

#lista delle curve disponibili
#openssl ecparam -list_curves | grep secp256k1
printf "\n\n \e[105m ######### vogliamo utilizzare la stessa curva ellittica di Bitcoin (secp256k1) #########\e[0m\n\n"
read
sed -n 4p ../main.txt
read
openssl ecparam -list_curves

printf "\n\n \e[105m ######### Filtriamo l'output (secp256k1) #########\e[0m\n\n"
read
printf '\e[31m\n- Che comando possiamo usare? 👨🏻‍🎓\e[0m\n\n'
read
sed -n 5p ../main.txt
read
openssl ecparam -list_curves | grep secp256k1

read
printf "\n\n \e[105m ######### Creo la chiave privata di Alice (privata_alice.pem) #########\e[0m\n\n"
read
sed -n 6p ../main.txt
read
openssl ecparam -genkey -name secp256k1 -rand /dev/urandom -noout -out privata_alice.pem

read
printf "\n\n \e[105m ######### Derivo la chiave pubblica (pubblica_alice.pem) di Alice dalla chiave privata  #########\e[0m\n\n"
read
sed -n 7p ../main.txt
read
openssl ec -in privata_alice.pem -pubout -out pubblica_alice.pem

printf "\n\e[32m ######### 👾 DEBUG chiave privata #########\e[0m\n\n"
read
printf '\e[31m\n- Che comando posso usare per visualizzare la chiave privata? 👨🏻‍🎓\e[0m\n\n'
read
sed -n 8p ../main.txt
read
cat privata_alice.pem

printf "\n\e[32m ######### 👾 DEBUG chiave pubblica #########\e[0m\n\n"
read
sed -n 9p ../main.txt
read
cat pubblica_alice.pem

read
printf "\n\n \e[101m Alice Crea il messaggio.txt \e[0m\n\n"
read
sed -n 10p ../main.txt
read
echo "Bob Ti amo!" > messaggio.txt

printf "\n\e[32m ######### 👾 DEBUG messaggio.txt #########\e[0m\n\n"
read
sed -n 11p ../main.txt
read
cat messaggio.txt

read
printf "\n\n \e[105m ######### Alice firma il messaggio (firma_alice.bin) #########\e[0m\n\n"
read
sed -n 12p ../main.txt
openssl dgst -sha256 -sign privata_alice.pem messaggio.txt > firma_alice.bin

read
printf "\n\e[32m ######### 👾 DEBUG firma_alice.bin #########\e[0m\n\n"
read
sed -n 13p ../main.txt
read
xxd -p firma_alice.bin |  tr -d '\n'  | awk '{print $1}'

#Sposto la chiave pubblica, la firma_alice.bin e il messaggio da bob
printf "\n\n \e[105m ######### Invio la chiave pubblica, la firma_alice.bin e il messaggio da bob ed infine mi sposto da Bob #########\e[0m\n\n"
read
sed -n 14p ../main.txt
cp ./{pubblica_alice.pem,firma_alice.bin,messaggio.txt} ../Bob && cd ../Bob

#Bob ver
#check firma_alice
read
printf "\n\n \e[101m Bob verifica la firma, utilizzando il messaggio in chiaro, la firma e la chiave pubblica di Alice \e[0m\n\n"
read
sed -n 15p ../main.txt
read
openssl dgst -sha256 -verify pubblica_alice.pem -signature firma_alice.bin messaggio.txt

read
printf '\e[31m\n- Esercizio: Alterare il messaggio e verificarlo di nuovo 👨🏻‍🎓\e[0m\n\n'
read
printf '\e[32mSoluzione\e[0m\n\n'
printf "\n\n \e[101m Altero il messaggio per far fallire la firma \e[0m\n\n"
read
sed -n 16p ../main.txt
read
echo "bla bla bla!" >> messaggio.txt

read
printf "\n\e[32m ######### 👾 DEBUG messaggio.txt #########\e[0m\n\n"
read
sed -n 17p ../main.txt
read
cat messaggio.txt

read
printf "\n\n \e[101m Bob verifica la firma, utilizzando il messaggio in chiaro, la firma e la chiave pubblica di Alice \e[0m\n\n"
read
sed -n 18p ../main.txt
read
openssl dgst -sha256 -verify pubblica_alice.pem -signature firma_alice.bin messaggio.txt
