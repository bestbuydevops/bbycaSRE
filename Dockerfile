#Best Buy DevOps Assignment - Samuel Baruffi

# Set mantainer 
LABEL maintainer="devopsbestbuy@gmail.com"

# Source Image
FROM node:8

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

# Port to be exposed if not set on docker run
EXPOSE 8080

# Start NPM (will trigger node)
CMD [ "npm", "start" ]
