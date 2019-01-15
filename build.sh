#!/bin/sh
rm -rf ./dist
rm -rf ./.vuepress/dist
#set -e
npx gluepress build

if [ $? -eq 0 ]
then
  mkdir ./dist
  mkdir ./dist/site
  mkdir ./dist/site/docs
  mv ./.vuepress/dist/* ./dist/site/docs
  cp logo.png ./dist/site/docs
  cp -R images ./dist/site/docs
  http-server ./dist/
else
  rm -rf ./dist
  rm -rf ./.vuepress/dist
fi


