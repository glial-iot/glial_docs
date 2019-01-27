#!/bin/sh
rm -rf ./dist
rm -rf ./.vuepress/dist
#set -e
npx gluepress build

if [ $? -eq 0 ]
then
  mkdir ./dist
  mkdir ./dist/docs
  mv ./.vuepress/dist/* ./dist/docs
  cp logo.png ./dist/docs
  cp -R images ./dist/docs
  http-server ./dist/
else
  rm -rf ./dist
  rm -rf ./.vuepress/dist
fi


