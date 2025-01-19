# Stage 1: Build Angular app
FROM --platform=arm64 node as builder
# Automatically create the directory if it doesn't exist.
WORKDIR /app
# Copy the rest of the application code
COPY . .
# Install dependencies
RUN npm install
# Build the Angular app
RUN npm run build

# Stage 2: Serve Angular app using NGINX
FROM --platform=arm64 nginx as ngx
# Copy built Angular app from Stage 1
COPY --from=builder /app/dist/angular-project/browser /usr/share/nginx/html
COPY /nginx-custom.conf  /etc/nginx/conf.d/default.conf
# Create NGINX cache directory
RUN mkdir -p /var/cache/nginx/client_temp
# Set ownership of NGINX cache directory
RUN chown -R nginx:nginx /var/cache/nginx

# Expose port 80
EXPOSE 8080

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]


# # Dockerfile

# # Stage 1: Build Angular application
# FROM --platform=linux/arm64 node AS builder
# WORKDIR /app
# COPY package.json package-lock.json ./
# RUN npm install
# COPY . .
# RUN npm run build

# # Stage 2: Serve Angular application using nginx
# FROM --platform=linux/arm64 nginx:alpine
# COPY --from=builder /app/dist/angular-project/browser /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]
