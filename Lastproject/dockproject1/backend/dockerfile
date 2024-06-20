FROM node
WORKDIR /app
COPY package*.json ./
RUN npm install
RUN npm install cors
COPY . .
EXPOSE 80
ENTRYPOINT [ "node","app.js" ]
