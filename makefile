#!make
include .env

build: html css img

node:
	@yarn

html: node
	@node node_modules/pug-cli -O src/data.js src/ -b src/ -o public/

css: node
	@node_modules/node-sass/bin/node-sass src/ -o public/

images = $(wildcard public/img/*.png public/img/*.jpg)
thumbs = $(subst img,img-thumbs, $(images:.png=.jpg))

.PHONE: img
img: $(thumbs)

public/img-thumbs/%.jpg: public/img/%.*
	@mkdir -p public/img-thumbs
	convert -quality 70 -scale 700\> $< $@

serve: build
	@(node node_modules/pug-cli -w -O src/data.js src/ -b src/ -o public/ &\
	  node_modules/node-sass/bin/node-sass -w src/ -o public/ &\
	  node server)

clean:
	@echo "Removing html files from public"
	@rm -f public/*.html
	@echo "Removing css files from public"
	@rm -f public/*.css
	@echo "Removing thumb images from public"
	@rm -f public/img-thumbs/*

sanity:
	@# TODO this should use ls
	@echo "Checking mirror links"
	@node -e " \
		require('./src/data').scenarios \
		.map(s => s.links.find(l => l.title === 'Mirror').href) \
		.filter(h => !require('fs').existsSync('public' + h)) \
		.forEach(h => console.log('Missing data file', h))"

deploy: build
	rsync -az public/ $(DEPLOY) --progress --delete
