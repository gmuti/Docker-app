# Étape 1 : Build de l'application Angular
FROM node:18 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run ng build -- --output-path=dist --configuration=production --verbose
# Étape 2 : Serveur pour l'application Angular
FROM nginx:alpine
COPY --from=build /app/dist/docker-app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
