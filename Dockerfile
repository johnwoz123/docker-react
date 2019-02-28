FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <-- all we care about

FROM nginx
#elastic beanstalk will use this exposed port
EXPOSE 80
# copy from the builder phase above - from directory - to directory
COPY --from=builder /app/build /usr/share/nginx/html