# Step 1: Use an official Node.js image to build the app
FROM node:16 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json to install dependencies first
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the entire project into the container
COPY . .

# Build the React app for production
RUN npm run build

# Step 2: Serve the built app using a lightweight web server (nginx)
FROM nginx:alpine

# Copy the build output from the previous stage into the nginx container
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
