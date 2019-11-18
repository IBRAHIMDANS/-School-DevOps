FROM node:latest

WORKDIR /app

ADD ./package.json .
ADD ./yarn.lock .
RUN npm install

COPY . .

EXPOSE 8080
CMD ["node", "index.js"]
