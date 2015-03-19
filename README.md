# docker.hhvm

...a really simple Docker container for playing around with Facebook's HHVM / Hack. Based on the excellent Docker-noobie friendly [phusion/baseimage](https://github.com/phusion/baseimage-docker).

The container doesn't have a database server configured. It should be fairly easy to add one, or spin up a new container dedicated to running a data store.

**Note:** Do not use this for anything resembling a production environment.

## Usage

First, build the container:

    # docker build -t hhvm .

nginx is pointed to `/code/public`. If you have hh or php files in your current directory, serving them via nginx + hhvm is super easy:

    # docker run -t -p 8000:80 -v $(pwd):/code/public:ro hhvm

Now navigate to [http://localhost:8000](http://localhost:8000)

## Development

There are tests written to ensure the Dockerfile is built correctly and a few integratino tests to ensure
php and hh are served correctly with the default nginx config. The tests rely on Ruby's rspec and docker-api.

	# bundle install
	# make test
