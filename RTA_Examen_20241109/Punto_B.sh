creé el archivo del script en la ubicación requerida y me aseguré de que todo estuviera bien configurado:

sudo vim /usr/local/bin/Baez_AltaUser-Groups.sh
Luego, le di permisos de ejecución al script para que pudiera correr sin problemas:


sudo chmod +x /usr/local/bin/Baez_AltaUser-Groups.sh
Después, me aseguré de que el script se ejecutara correctamente y de que recibiera los parámetros necesarios. Probé con un usuario de referencia y un archivo de usuarios como parámetros:


sudo /usr/local/bin/Baez_AltaUser-Groups.sh santiago ~/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt
Verifiqué que el archivo de script estuviera en la ubicación correcta y que tuviera los permisos adecuados:

ls -l /usr/local/bin/Baez_AltaUser-Groups.sh
Detalles del script
El script toma dos parámetros:

El usuario de referencia (del que se saca la contraseña encriptada).
El archivo de usuarios (que contiene una lista de nuevos usuarios, sus grupos y directorios de inicio).
Primero, obtuve la contraseña encriptada del usuario de referencia usando getent para asegurarme de que los nuevos usuarios tuvieran la misma contraseña:


CONTRA=$(sudo getent shadow "$PASS" | cut -d: -f2)
Luego, leí el archivo de usuarios línea por línea para procesar cada entrada, extrayendo el nombre de usuario, grupo y directorio de inicio. Me aseguré de que cada grupo se creara si no existía y de que se configuraran los directorios de inicio:


sudo groupadd -f "$GRUPO"
if [ ! -d "$HOME_USR" ]; then
    sudo mkdir -p "$HOME_USR"
fi
Finalmente, creé los usuarios con useradd, asignando la contraseña encriptada y configurando el shell y el grupo correspondientes:


sudo useradd -m -d "$HOME_USR" -s /bin/bash -g "$GRUPO" -p "$CONTRA" "$USUARIO"
Verificación de resultados
Para asegurarme de que todo funcionara bien, revisé si los grupos y usuarios se habían creado correctamente con comandos como getent
getent group nombre_grupo
Revisé las propiedades de los directorios de trabajo para confirmar que se habían configurado adecuadamente:
