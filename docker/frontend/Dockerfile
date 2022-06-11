FROM node:16.15

WORKDIR /app
COPY ./ /app
RUN npm install
COPY ./src /app/src
COPY ./public /app/public

COPY ./src ./app/src
ENTRYPOINT ["npm", "start"]
