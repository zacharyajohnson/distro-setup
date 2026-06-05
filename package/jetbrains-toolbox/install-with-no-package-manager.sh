#!/bin/sh

(
cd '/tmp' || exit

curl -o 'jetbrains-toolbox.tar.gz' -L 'https://data.services.jetbrains.com/products/download?platform=linux&code=TBA'

tar -xvf 'jetbrains-toolbox.tar.gz'
rm 'jetbrains-toolbox.tar.gz'

sudo mv /tmp/jetbrains-toolbox-* "/usr/local/bin/jetbrains-toolbox"

)
