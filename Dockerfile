FROM nginx:1.27.2 AS build 

#Webapp files to the Nginx html directory in the build stage
COPY . /usr/share/nginx/html

#start nginx with webapp 
CMD ["nginx", "-g", "daemon off;"]

#Use a distroless base image for the final stage
FROM gcr.io/distroless/static-debian11
COPY --from=build /usr/share/nginx/html /usr/share/nginx/html


#copy the default nginx config file
COPY --from=build /etc/nginx /etc/nginx

# Run Nginx in the foreground (since there's no shell in distroless)
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
