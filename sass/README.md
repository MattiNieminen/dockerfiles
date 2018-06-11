# dockerfiles

Docker image for compiling / converting .sass and .scss files to each other and
CSS.

## Usage

Build the image after cloning this repository with

```bash
docker build -t my-sass .
```

Then replace the `<path/to/sass/files>` in the following command and run it

```bash
docker run -it --rm -v <path/to/sass/files>:/root/workdir/ my-sass /bin/bash
```

You will get a prompt with ```sass``` and ```sass-convert``` installed to PATH.
You SASS files (*.scss or *.sass) in <path/to/sass/files> on your host will be
mounted to ```workdir``` in the container.

For example, to convert .sass files to .scss files, do

```bash
sass-convert my-sass.sass my-scss.scss
```

See ```sass --help``` and ```sass-convert --help``` for more details.
