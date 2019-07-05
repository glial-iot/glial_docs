.DEFAULT: build

build: remove process_docs
	mkdir ./dist
	mkdir ./dist/docs
	mv ./.vuepress/dist/* ./dist/docs
	cp logo.png ./dist/docs
	cp -R images ./dist/docs

process_docs: clean
	npx gluepress build

clean:
	rm -rf ./dist
	rm -rf ./.vuepress/dist

remove:
	rm -rf ./dist
	rm -rf ./.vuepress/dist

server:
	http-server ./dist/
