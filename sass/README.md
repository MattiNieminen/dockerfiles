# dockerfiles

Docker image for compiling / converting .sass and .scss files to each other and
CSS.

## Usage

Build the image after cloning this repository with

```bash
docker build -t my-sass .
```

Then run the container interactively with

```bash
docker run -it --rm -v $PWD/workdir:/root/workdir/ my-sass /bin/bash
```

You will get a prompt with ```sass``` and ```sass-convert``` installed to PATH.
Put all your SASS (*.scss or *.sass) files on your host to directory
```workdir``` in this directory, and they will be mounted to your containers
WORKDIR.

For example, convert .sass files to .scss files, put them to ```workdir```
and do

```bash
sass-convert my-sass.sass my-scss.scss
```

See ```sass --help``` and ```sass-convert --help``` for more details.
