#!make
include .env

build: html css

html:
	@pug -O src/data.js src/ -b public/ -o public/

css:
	@node-sass src/ -o public/

clean:
	@echo "Removing html files from public"
	@rm public/*.html
	@echo "Removing css files from public"
	@rm public/*.css

node:
	@yarn

serve: node
	@(pug -O src/data.js -w src/ -b public/ -o public/ &\
	  node-sass -w src/ -o public/ &\
	  node server)

deploy: build
	rsync -az public/ $(DEPLOY) --progress --delete
