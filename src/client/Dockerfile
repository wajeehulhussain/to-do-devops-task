# Stage 1: Build stage
FROM node:16-alpine as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install 

# Copy the rest of the application files
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Production stage
FROM nginx:alpine

# Copy the built files from the build stage to the nginx server
COPY --from=build /app/build /usr/share/nginx/html
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

#Generation of Nginx Logs
RUN mkdir /usr/share/nginx/log

# Expose port 80 to the outside world
EXPOSE 80

# Default command to start nginx server
CMD ["nginx", "-g", "daemon off;"]


