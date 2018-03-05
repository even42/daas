# HowTo

## Install

In order to execute the DAAS in localhost env, add in /etc/hosts :
- http://symfony.local
- http://drupal.local
- http://node.local:8080

## Usefull
 
#### stop all containers:
`docker kill $(docker ps -q)`
#### remove all containers
`docker rm $(docker ps -a -q)`
#### remove all docker images
`docker rmi $(docker images -q)
