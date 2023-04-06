#!/bin/bash

URL=""
SAYI=0

while getopts ":h:n:" opt; do
  case $opt in
    h)
      URL=$OPTARG
      ;;
    n)
      SAYI=$OPTARG
      ;;
    \?)
      echo "Geçersiz Argüman: -$OPTARG" >&2
      echo -n "Geçerli Argümanlar: -h [URL] , -n [SAYI]" >&2
      exit 1
      ;;
    :)
      echo "Argüman -$OPTARG için bir sayı giriniz." >&2
      exit 1
      ;;
  esac
done

if [[ -z $URL ]] || [[ $SAYI -eq 0 ]]; then
  echo "Kullanım: $0 -h URL -n SAYI" >&2
  exit 1
fi

count=$(ps aux | grep curl | wc -l)
while $count -lt $SAYI; do
  curl -L "$URL">/dev/null 2>&1 &
  ((count++))
  if [[ count -eq $SAYI ]];
  then
    count=0
  fi
done
