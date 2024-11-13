Modificar el index.html: Primero, edité el archivo index.html con los cambios que me pidieron.

Crear la imagen de Docker: Usé el comando docker build -t web1-baez . para crear la imagen de Docker basada en nginx con el archivo index.html que modifiqué.

Subir la imagen a Docker Hub: Luego de crear la imagen, la subí a Docker Hub con los comandos docker tag y docker push para tenerla disponible online.

Levantar la imagen: Finalmente, ejecuté el contenedor con el comando docker run -d -p 8080:80 fishit/web1-baez para que mi página se levantara en el puerto 8080.
