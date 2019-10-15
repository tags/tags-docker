FROM ubuntu

RUN apt-get update && apt-get install -y r-base python-dev python-pip 
RUN apt-get install -y python-rpy2 python-pymongo supervisor 
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
RUN apt-get update && sudo apt-get install -y mongodb-org-mongos

# Install GeoLight
RUN echo "install.packages('GeoLight', repos=\"http://cran.rstudio.com/\")" > packages.R
RUN Rscript  packages.R

# Get working dir ready for celery
RUN mkdir /opt/celeryq
WORKDIR /opt/celeryq
ADD requirements.txt /opt/celeryq/requirements.txt
ADD geologger /opt/celeryq/geologger
RUN pip install -r /opt/celeryq/requirements.html  

