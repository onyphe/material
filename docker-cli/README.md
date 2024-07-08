# Docker image for ONYPHE CLI tool

## Run an existing image

If you just want to run the latest ONYPHE CLI in a docker container please see the documentation [here https://www.onyphe.io/docs/cli/installation](https://wwW.onyphe.io/docs/cli/installation)

## Build your own image

One reason you may wish to build your own docker image is to put the API key directly into the image, avoiding the need to mount a volume.

Building the Docker image requires a tarball of the ONYPHE cli source files. You can obtain this tarball in one of two ways :

1. Clone the onyphecli repository and manually create a tar.gz
2. Build the client and create a distribution package

### Clone the onyphecli repo and manually create a tar.gz

~~~ bash
git clone https://github.com/onyphe/cli.git
cd cli
tar -czf ../Onyphe-<version>.tar.gz *
~~~


The current version can be found by looking in the Changes file.

### Build the client and create a distribution package

Follow the build instructions [here https://github.com/onyphe/cli](https://github.com/onyphe/cli) until step 3.

At step 4, create a distribution package instead of using the intall command

~~~ bash
perl Build.PL
./Build && ./Build test
./Build dist
~~~

Copy the resulting Onyphe-<version>.tar.gz into this cloned repository, that is, in the same directory as the Dockerfile.

### Build the docker image

1) Edit the Dockerfile with the current client version on line 2 (currently 4.14) and if desired (probably the reason you are doing this) your API key on line 10

2) Run the docker build command

~~~ bash
docker build -t onyphecli:latest .
docker run onyphecli:latest -user
~~~

Check your API key by running the container with the -user parameter which returns information about your user account.

The build process will require an outgoing Internet connection to download the dependencies for the build process.
