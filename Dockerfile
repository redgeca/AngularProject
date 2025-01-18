# FROM nginx:alpine 
# COPY dist/angular-project /usr/share/nginx/html 
# COPY nginx-custom.conf /etc/nginx/conf.d/default.conf 
# EXPOSE 80 
# CMD ["nginx", "-g", "daemon off;"]



FROM node:23-alpine3.20 AS angular_base
WORKDIR /app

COPY . .
RUN npm install
RUN npm run build

FROM httpd:2.4-alpine
WORKDIR /usr/local/apache2/htdocs
COPY --from=angular_base /app/dist/angular-project .

EXPOSE 4200