# From this 'FROM' command, everything will be refered to as 'builder'
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# By using a second 'FROM' command, docker knows the previous build is finished
FROM nginx
# This specifies that we want to copy something from the 'builder' phase
# [buildphase] [copy which folder] [destination in container]
COPY --from=builder /app/build /usr/share/nginx/html

# The default start command of the nginx container run the server. No need the specify
