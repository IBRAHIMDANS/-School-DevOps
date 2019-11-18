FROM node:11 AS container_name

WORKDIR /app

COPY ./package.json ./
RUN npm install

COPY . .
RUN npm run-script build

FROM nginx:alpine
COPY --from=container_name /app/build /usr/share/nginx/html
