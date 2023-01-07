#!/bin/bash

cd ~/projects/jpdesc.com

make html
make publish

rsync -avzh ./output/* root@jpdesc.com:/var/www/html/
