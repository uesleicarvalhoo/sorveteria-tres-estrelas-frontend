FROM node:lts-alpine as builder

WORKDIR /app

# Copy the package.json and install dependencies
COPY package.json ./

COPY yarn.lock ./

RUN yarn install --frozen-lockfile

# Copy rest of the files
COPY . .

ARG VUE_APP_API_URL

# Build the project
RUN VUE_APP_API_URL=${VUE_APP_API_URL} yarn run build

FROM nginx:alpine as production-build

COPY ./.nginx/nginx.conf /etc/nginx/nginx.conf

## Remove default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy from the stag builder
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]