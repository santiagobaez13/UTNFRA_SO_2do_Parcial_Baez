#!/bin/bash

# Corro la imagen generada anteriormente
docker run -d -p 8080:80 fishit/web1-baez

echo 
echo "Entre en: http://localhost:8080"
echo 

# Mostrar contenedores activos
docker ps

