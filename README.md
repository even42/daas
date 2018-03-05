# HowTo

## Install

In order to execute the DAAS in localhost env, add in /etc/hosts :
- symfony.local
- drupal.local
- node.local:8080

## Get started

### Run the DaaS
`make start`

### Stop the DaaS
`make stop`

### Test the DaaS

In order to test the DaaS check the urls below :

- http://symfony.local
- http://drupal.local
- http://node.local:8080


## Usefull
 
#### stop all containers:
`docker kill $(docker ps -q)`
#### remove all containers
`docker rm $(docker ps -a -q)`
#### remove all docker images
`docker rmi $(docker images -q)`
