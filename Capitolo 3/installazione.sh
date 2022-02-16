#!/bin/sh

if [ $# -ge 1 ]
then
    VERSION=$1
    SO=$2
else
    VERSION=22.0
    SO=osx64
fi

printf "\e[32m ######### Hello, "$USER".  Are you ready for Bitcoin World? #########\e[0m\n\n"
read continue


printf "\n\n \e[101m ######### Download Bitcoin core #########\e[0m\n\n"
wget https://bitcoincore.org/bin/bitcoin-core-$VERSION/bitcoin-$VERSION-$SO.tar.gz

printf "press [ENTER] to continue"
read continue

printf "\n\n \e[101m ######### Download Hashes #########\e[0m\n\n"
wget https://bitcoincore.org/bin/bitcoin-core-$VERSION/SHA256SUMS

printf "press [ENTER] to continue"
read continue
printf "\n\n \e[101m ######### Check the software #########\e[0m\n\n"
sha256sum --ignore-missing --check SHA256SUMS


printf "press [ENTER] to continue"
read continue
printf "\n\n \e[101m ######### Download Signatures #########\e[0m\n\n"
wget https://bitcoincore.org/bin/bitcoin-core-$VERSION/SHA256SUMS.asc


printf "press [ENTER] to continue"
read continue
printf "\n\n \e[42m ######### imports and check the signatures #########\e[0m\n\n"
gpg --verify SHA256SUMS.asc SHA256SUMS

printf "press [ENTER] to continue"
read continue
printf "\n\n \e[101m ######### Extract the package#########\e[0m\n\n"
tar -xvf bitcoin-$VERSION-$SO.tar.gz

printf "press [ENTER] to continue"
read continue
printf "\n\n \e[101m ######### Checking the "\$PATH" #########\e[0m\n\n"
echo $PATH

printf "press [ENTER] to continue"
read continue
printf '\e[32mCopy bin/bitcoin* in /usr/local/bin/ (check if /usr/local/bin/ is in your $PATH)\e[0m\n\n'
sudo cp bitcoin-$VERSION/bin/bitcoin* /usr/local/bin/.

printf "press [ENTER] to continue"
read continue
printf "\n\n \e[42m ######### Check Bitcoin core version  #########\e[0m\n\n"
bitcoind -version

printf "press [ENTER] to continue"
read continue
printf "\n\n \e[42m ######### Check the path #########\e[0m\n\n"
which -a bitcoind

printf '\e[32m Cleaning \e[0m\n\n'
rm -Rf SHA256SUMS* bitcoin*
echo "\n"
printf "\e[43mBitcoin In Action 🚀\e[0m "
