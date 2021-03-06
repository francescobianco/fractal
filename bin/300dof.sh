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
while IFS="" read -r fractal_url || [ -n "${fractal_url}" ]; do
  post_date=$(date --date "${start_date} ${days} day" +'%a %d/%m/%Y' | tr '[a-z]' '[A-Z]')
  tweet="Fractal"
  domain="$(echo ${fractal_url} | sed -e 's/[^/]*\/\/\([^@]*@\)\?\([^:/]*\).*/\2/')"
  tweet_url="https://francescobianco.github.io/fractal/post/300-days-of-fractal/day-${day}.html"
  intent="https://twitter.com/intent/tweet?text=${tweet}&url=${tweet_url}"
  echo "- \`${post_date} D${day}\` [✍](${intent})" >> 300DOF.md
  sed -e 's!{fractal_url}!'"${fractal_url}"'!' \
    -e 's!{day}!'"${day}"'!' \
    -e 's!{tweet_url}!'"${tweet_url}"'!' \
    -e 's!{domain}!'"${domain}"'!' \
    -e 's!%%PHP_VERSION%%!'"${php_version}"'!' \
    -r etc/300dof.tpl > post/300-days-of-fractal/day-${day}.html
  offset="${offset:1:5}${offset:0:1}"
  days=$((${days} + ${offset:0:1}))
  day=$((${day} + 1))
done < etc/fractal.list
