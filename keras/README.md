# dockerfiles

Docker image for Keras and Jupyter Notebook (CPU-support only).

## Usage

Build the image after cloning this repository with

```bash
docker build -t my-keras .
```

Then replace the `<random-token-string>` and `<path/to/notebooks>` in the
following command and run it

```bash
docker run --rm -p 8888:8888 -e "TOKEN=<random-token-string>" -v <path/to/notebooks>:/root/workdir/ my-keras
```

Jupyter will start in http://localhost:8888 with <path/to/notebooks> mounted as
a volume. Use the <random-token-string> to login.
