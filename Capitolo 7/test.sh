H1=15b88c5107195bf09eb9da89b83d95b3d070079a3c5c5d3d17d0dcd873fbdacc
H2=c46e239ab7d28e2c019b6d66ad8fae98a56ef1f21aeecb94d1b1718186f05963
H3=1d0cb83721529a062d9675b98d6e5c587e4a770fc84ed00abc5a5de04568a6e9
OMRK=f3e94742aca4b5ef85488dc37c06c3282295ffec960994b2c0d5ac2a25a95766

printf "\n\n \e[45m RES1 \e[0m\n\n"
RES1=$(printf $H2$H3 | xxd -r -p | sha256sum -b | xxd -r -p | sha256sum -b | awk '{print $1}')
printf $RES1

read;
printf "\n\n \e[45m RES2 \e[0m\n\n"
RES2=$(printf $H1$RES1 | xxd -r -p | sha256sum -b | xxd -r -p | sha256sum -b| awk '{print $1}')
printf $RES2

read;
printf "\n\n \e[45m MKR \e[0m\n\n"
MKR=$(printf $RES2 | tac -rs ..)
printf $MKR

read;
printf "\n\n \e[45m Verifca Merkle root \e[0m\n\n"
test $MKR = $OMRK  && echo sono uguali || echo sono diversi