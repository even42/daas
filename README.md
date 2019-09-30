# HowTo

## Install

In order to execute the DAAS in localhost env, add in /etc/hosts :
- drupal.local (back)
- graphql.local (services)
- node.local (front)
- nginx.local (web server)
- krackenD.local (API Gateway)
- varnish.local (reverse proxy cache)


`127.0.0.1   localhost drupal.local node.local varnish.local krackend.loca`


## Get started


#### Run the DaaS first time
`make install`


#### Build the DaaS
`make build`

#### Stop the DaaS
`make stop`

#### Test the DaaS

In order to test the DaaS check the urls below :

- http://drupal.local:8080
- http://node.local:8080
- http://varnish.local

## Usefull
 
#### stop all containers:
`docker kill $(docker ps -q)`
#### remove all containers
`docker rm $(docker ps -a -q)`
#### remove all docker images
`docker rmi $(docker images -q)`
