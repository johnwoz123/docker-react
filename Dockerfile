FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <-- all we care about

FROM nginx
# copy from the builder phase above - from directory - to directory
COPY --from=builder /app/build /usr/share/nginx/html