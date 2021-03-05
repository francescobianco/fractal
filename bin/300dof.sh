#!/usr/bin/env bash

echo "Sourcing..."
rm -f etc/fractal.list && true
while IFS="" read -r url || [ -n "${url}" ]; do
  wget -kqO index.html "${url}"
  cat index.html | grep img | grep -Po 'src="\K.*?(?=")' >> etc/fractal.list
  rm -f index.html
done < etc/sources.list

echo "Pruning images..."
sed -i '/\.\(png\|jpg\|jpeg\)$/I!d' etc/fractal.list
sort -R --random-source etc/random etc/fractal.list

echo -e "# 300 Days of Fractal\n" > 300DOF.md
while IFS="" read -r url || [ -n "${url}" ]; do
  echo "- [✍](${url})"  >> 300DOF.md
done < etc/fractal.list

