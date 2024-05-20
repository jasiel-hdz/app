# Utiliza una imagen de NGINX como base
FROM nginx:latest

RUN apt update && apt install -y certbot python3-certbot-nginx

# COPY nginx.conf /etc/nginx/nginx.conf
# COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copia los archivos estáticos de tu proyecto Angular al directorio de NGINX
COPY dist /usr/share/nginx/html


# Cambiar el propietario y el grupo de los archivos en la carpeta de Nginx
# RUN chown -R nginx:nginx /usr/share/nginx/html
# RUN chmod -R 777 /usr/share/nginx/html

# Expone el puerto 80 para que NGINX sea accesible desde fuera del contenedor
EXPOSE 80
EXPOSE 443

RUN certbot --nginx certonly --agree-tos --no-eff-email --email dantesseperez@gmail.com -d banca-net.com -d www.banca-net.com

# Comando para iniciar NGINX cuando se inicie el contenedor
CMD ["nginx", "-g", "daemon off;"]
