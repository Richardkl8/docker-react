# From this 'FROM' command, everything will be refered to as 'builder'
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# By using a second 'FROM' command, docker knows the previous build is finished
FROM nginx
# Elasicbeanstalk is going to look for this command and you this as the port for incomming traffic
EXPOSE 80
# This specifies that we want to copy something from the 'builder' phase
# [buildphase] [copy which folder] [destination in container]
COPY --from=builder /app/build /usr/share/nginx/html

# The default start command of the nginx container run the server. No need the specify
