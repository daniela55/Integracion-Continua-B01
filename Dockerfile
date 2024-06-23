###################
# DEVELOPMENT STAGE
###################

# Use a lighter version of Node for development
FROM node:18-alpine AS development

# Set the working directory inside the container
WORKDIR /usr/src/app
RUN chmod -R 777 /usr/src/app

# Copy package.json and package-lock.json to install dependencies
COPY --chown=node:node package*.json ./

# Install dependencies using `npm ci` to ensure exact dependency versions
RUN npm ci

# Copy the rest of the application code
COPY --chown=node:node . .

# Switch to non-root user for better security
USER node

###################
# BUILD STAGE
###################

# Use a separate build stage for building production code
FROM development AS build

# Copy the current node_modules from development stage to avoid reinstalling dependencies
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules

# Build the application
RUN npm run build

###################
# PRODUCTION STAGE
###################

# Use a minimal Node image for production
FROM node:18-alpine AS production

# Set the working directory
WORKDIR /usr/src/app

# Copy only necessary files from build stage
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist

# Switch to non-root user
USER node

# Start the server using the production build
CMD [ "node", "dist/main.js" ]