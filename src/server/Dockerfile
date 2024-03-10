# Stage 1: Build stage
FROM node:17-alpine AS build

WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Stage 2: Final stage
FROM node:17-alpine

WORKDIR /usr/src/app

# Copy only necessary files from the build stage
COPY --from=build /usr/src/app/ ./

# Expose port 3000
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]