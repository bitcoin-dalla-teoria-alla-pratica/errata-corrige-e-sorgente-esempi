H1=8d9d737b484e96eed701c4b3728aea80aa7f2a7f57125790ed9998f9050a1bef
H2=90e03319ddc9d48da38ab39b2f37c0a5af5afc736f6ff2a9d8b8653e0feb308d
H3=84251842a4c0f0e188e1c2bf643ec37a1402dd86a25a9ab5004633467d16e313
OMRK=be0b136f2f3db38d4f55f1963f0acac506d637b3c27a4c42f3504836a4ec52b1

printf "\n\n \e[45m RES1 \e[0m\n\n"
RES1=$(printf $H2$H3 | xxd -r -p | sha256sum -b | xxd -r -p | sha256sum -b | awk '{print $1}')
printf $RES1
read;

printf "\n\n \e[45m RES2 \e[0m\n\n"
RES2=$(printf $RES1$RES1 | xxd -r -p | sha256sum -b | xxd -r -p | sha256sum -b | awk '{print $1}')
printf $RES2

read;
printf "\n\n \e[45m RES3 \e[0m\n\n"
RES3=$(printf $RES2$RES2 | xxd -r -p | sha256sum -b | xxd -r -p | sha256sum -b | awk '{print $1}')
printf $RES3

read;
printf "\n\n \e[45m RES4 \e[0m\n\n"
RES4=$(printf $H1$RES3 | xxd -r -p | sha256sum -b | xxd -r -p | sha256sum -b | awk '{print $1}')
printf $RES4

read;
printf "\n\n \e[45m MKR \e[0m\n\n"
MKR=$(printf $RES4 | tac -rs ..)
printf $MKR

read;
printf "\n\n \e[45m Verifca Merkle root \e[0m\n\n"
test $MKR = $OMRK  && echo sono uguali || echo sono diversi