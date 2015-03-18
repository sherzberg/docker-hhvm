FROM phusion/baseimage:0.9.16

WORKDIR /code/public

# set correct environment variables.
ENV HOME /root

# use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# install add-apt-repository
RUN sudo apt-get update
RUN sudo apt-get install -y software-properties-common python-software-properties

# we'll need wget to fetch the hhvm key...
RUN sudo apt-get install -y wget

# install hhvm
RUN wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
RUN echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list
RUN sudo apt-get update
RUN sudo apt-get install -y hhvm-nightly

# install nginx
RUN sudo apt-get install -y nginx
# the init system of phusion/baseimage handles daemonization
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN mkdir /etc/service/nginx
ADD nginx.sh /etc/service/nginx/run

RUN mkdir /etc/service/hhvm
ADD hhvm.sh /etc/service/hhvm/run

# set up nginx default site
ADD nginx-default /etc/nginx/sites-available/default

# install fastcgi for hhvm
RUN sudo /usr/share/hhvm/install_fastcgi.sh

# clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# expose port 80
EXPOSE 80
