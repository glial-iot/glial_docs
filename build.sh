#!/bin/sh
npx gluepress build &&
rm -rf ./dist/ ;
mkdir ./dist ;
mkdir ./dist/site ;
mkdir ./dist/site/docs ;
mv ./.vuepress/dist/* ./dist/site/docs &&
cp logo.png ./dist/site/docs &&
cp -R images ./dist/site/docs &&
http-server ./dist/
