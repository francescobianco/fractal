#!/usr/bin/env bash

start_date="2021-03-01"

#echo "Sourcing..."
#rm -f etc/fractal.list && true
#while IFS="" read -r url || [ -n "${url}" ]; do
#  wget -kqO index.html "${url}"
#  cat index.html | grep img | grep -Po 'src="\K.*?(?=")' >> etc/fractal.list
#  rm -f index.html
#done < etc/sources.list
#
#echo "Pruning images..."
#sed -i '/\.\(png\|jpg\|jpeg\)$/I!d' etc/fractal.list
#sort -R --random-source etc/random etc/fractal.list

day=1
days=0
offset=11113
echo -e "# 300 Days of Fractal\n" > 300DOF.md
while IFS="" read -r url || [ -n "${url}" ]; do
  post_date=$(date --date "${start_date} ${days} day" +'%a %d/%m/%Y' | tr '[a-z]' '[A-Z]')
  echo "- \`${post_date} D${day}\` [✍](${url})" >> 300DOF.md
  offset="${offset:1:5}${offset:0:1}"
  days=$((${days} + ${offset:0:1}))
  day=$((${day} + 1))
done < etc/fractal.list
