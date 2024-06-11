# Use the official Node.js image with a specific version
FROM node:22

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Install OpenSSH client
RUN apt-get update && apt-get install -y openssh-client

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory, excluding node_modules
COPY . .

# Ensure .dockerignore is used to exclude unnecessary files
# Create a .dockerignore file in your project with the following content:
# node_modules
# .git
# *.log
# Dockerfile
# docker-compose.yml
# .dockerignore

# Expose the ports that the Expo development server will use
EXPOSE 8081 19000 19001 19002

# Expose the port for code-server
EXPOSE 8080

# Environment variable to set the marketplace
ENV EXTENSIONS_GALLERY='{"serviceUrl":"https://marketplace.visualstudio.com/_apis/public/gallery","itemUrl":"https://marketplace.visualstudio.com/items","resourceUrlTemplate": "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/{publisher}/vsextensions/{extensionName}/{version}/vspackage"}'

# Start the Expo development server and code-server
CMD ["sh", "-c", "code-server /app --bind-addr 0.0.0.0:8080"]
