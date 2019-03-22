#!/bin/bash
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
ORANGE='\033[0;33m'
PUR='\033[0;35m'
GRN="\e[32m"
WHI="\e[37m"
NC='\033[0m'
banner(){
    printf "

	------------------------------------
	           MD5 -> Decrypt
	------------------------------------
    "
}
scanskrng(){
    cek=$(curl -s "https://md5.pinasthika.com/api/decrypt?value=$2" -L | jq --raw-output '.result')
    if [[ $cek == "" ]]; then
        printf "${HIJAU}GAGAL => $1 : $cek \n">> nemu.txt
    else if [[ $cek == null ]]; then
            printf "${MERAH}GAGAL => $1 : $cek\n">> nemu.txt
        else
            printf "${HIJAU}BERHASIL => $1 : $cek \n">> nemu.txt
        fi
    fi
}
banner
echo "Delimeter list -> email:password "
echo -n "Put Your List : "
read list
if [ ! -f $list ]; then
    echo "$list No Such File"
    exit
fi
x=$(gawk -F: '{ print $1 }' $list)

y=$(gawk -F: '{ print $2 }' $list)
IFS=$'\r\n' GLOBIGNORE='*' command eval  'emailna=($x)'
IFS=$'\r\n' GLOBIGNORE='*' command eval  'passwordna=($y)'
for (( i = 0; i < "${#emailna[@]}"; i++ )); do
    em="${emailna[$i]}"
    pw="${passwordna[$i]}"
    scanskrng $em $pw
done
