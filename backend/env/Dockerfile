FROM node:16

WORKDIR /usr/src/app

COPY package*.json ./

COPY env/ecosystem.config.js ./

COPY server.js ./

ENV TZ=Asia/Taipei

RUN npm install & npm install pm2 mocha -g

EXPOSE 8080
