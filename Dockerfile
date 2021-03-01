# Use nginx to serve the application ##
#FROM nginx:alpine

## Remove default nginx website  
#RUN rm -rf /usr/share/nginx/html/*

## Copy over the artifacts in dist folder to default nginx public folder  
#COPY /dist/DockerHello-World /usr/share/nginx/html

## nginx will run in the forground  
#CMD [ "nginx", "-g", "daemon off;" ]

##from slide 25 in the notes from week 4


FROM node AS builder

WORKDIR /DockerHello-World

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:1.13.12-alpine

COPY --from=builder /DockerHello-World/dist/DockerHello-World /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
