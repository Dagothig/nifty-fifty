#!make
include .env

build: html css

node:
	@yarn

html:
	@pug -O src/data.js src/ -b public/ -o public/

css: node
	@node-sass src/ -o public/

serve: node
	@(pug -O src/data.js -w src/ -b public/ -o public/ &\
	  node-sass -w src/ -o public/ &\
	  node server)

clean:
	@echo "Removing html files from public"
	@rm public/*.html
	@echo "Removing css files from public"
	@rm public/*.css

deploy: build
	rsync -az public/ $(DEPLOY) --progress --delete
