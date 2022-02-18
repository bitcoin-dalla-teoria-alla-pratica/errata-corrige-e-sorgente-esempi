printf "\n\n \e[41m Generiamo il seed dall entropia \e[0m\n\n"
sleep 5

printf "\n\n \e[45m partiamo dall'entropia \e[0m\n\n"
EN=0168071cf29dbdf232de82fa34acb933
EN=$(xxd -u -l 16 -p /dev/urandom)
printf $EN
sleep 2

printf "\n\n \e[45m Applichiamo lo SHA256 per ottenere il checksum. \e[0m\n\n"
CHECK=$(printf $EN | xxd -r -p | sha256sum -b | head -c 1)
printf $CHECK
sleep 2

printf "\n\n \e[45m Appendiamo il checksum all’entropia e convertiamo in base2. \e[0m\n\n"
BASE2=$(echo "ibase=16; obase=2; $(echo $EN$CHECK  | tr '[:lower:]' '[:upper:]') " | bc  | sed 's/\\//g' | tr -d '\n')
printf $BASE2
sleep 2

printf "\n\n \e[45m incasellare in 11 bits ciascuno. \e[0m\n\n"
printf $BASE2 | sed 's/.\{11\}/& /g'| tr " " "\n" > base2.txt
cat base2.txt
sleep 2
printf "\n\n \e[45m Verifico se ho bisgono del Padding, quanti bits ha l'ultima riga? \e[0m\n\n"
PAD=$(tail -n 1 base2.txt| tr -d '\n' | wc -c)
printf $PAD
PADDING=0
sleep 2
if [ $PAD -eq 11 ];
  then
      printf "\n\n \e[45m Non devo aggiungere niente \e[0m\n\n"
  else
      PADDING=$(expr 11 - $PAD)
      printf "\n\n \e[45m Devo aggiungere $PADDING zeri in cima\e[0m\n\n"
  fi


sleep 2

while [ $PADDING -ne 0 ]
do
  echo '0' | cat - base2.txt| tr -d '\n' | tr " " "\n" > temp && mv temp base2.txt | tr -d '\n'  
  PADDING=$(expr $PADDING - 1)
done

sleep 2
printf "\n\n \e[45m Aggiunto il padding per avere blocchetti da 11 bits \e[0m\n\n"
cat base2.txt | sed 's/.\{11\}/& /g' | tr -d '\n' | tr " " "\n" > base2_11.txt
cat base2_11.txt

sleep 2
printf "\n\n \e[45m Mappo i bytes al dizionario inglese \e[0m\n\n"
file="base2_11.txt"
last_line=$(wc -l < $file)
current_line=0

#convert from BASE2 to BASE10
MAP=''
while IFS= read -r line; do
    BASE10=$(echo "ibase=2; $line" | bc)
    BASE10FIX=$(expr $BASE10 + 1) 
    WORD=$(sed ''$BASE10FIX'!d' dizionario.txt)    
    printf "$WORD "
done < $file