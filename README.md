Little pile of files to build the [gallery of released scenarios for ocalhoun's Nifty Fifty](https://nifty-fifty.rct.dagothig.com/). You build this through `make`:
* `make build` - prepares everything
* `make html` - compiles the pug files to html using [pug-cli](https://github.com/pugjs/pug-cli)
* `make css` - compiles the sass files to css using [node-sass](https://github.com/sass/node-sass)
* `make img` - uses `convert` from [ImageMagick](https://imagemagick.org) to create thumbnails
* `make clean` - cleans the public folder
* `make node` - runs yarn to install the dev server dependencies
* `make serve` - watches files for compilation and serves them through a little express.js server - this has a few limitations; `data.js` and images aren't watched
* `make deploy` - deploys the public folder using rsync. Assumes a .env file containing a DEPLOY destination variable
