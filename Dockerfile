##this dockerfile has 2 phases ('builder' and the run phase.)
#first phase uses node img to copy our files, and build the project.
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

##this second phase will copy the build folder from the previous builder phase
#and place it in the nginx/html folder (used for serving static content)
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html 
