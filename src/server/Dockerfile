FROM node:17-alpine

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install

COPY . .
EXPOSE 3000

# ENV MONGO_URL mongodb+srv://<user>:<pwd>@cluster0.kua20.mongodb.net/?retryWrites=true&w=majority

CMD ["npm", "start" ]