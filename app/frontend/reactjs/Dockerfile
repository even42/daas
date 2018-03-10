FROM node:9

# Create app directory
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

COPY package.json /var/www/html

ADD src /var/www/html/src

RUN npm install pm2 -g
RUN npm install

CMD ["npm", "start"]