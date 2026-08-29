FROM nginx:alpine

RUN echo "Hello from jenkins deployment!" > /usr/share/nginx/html/index.html