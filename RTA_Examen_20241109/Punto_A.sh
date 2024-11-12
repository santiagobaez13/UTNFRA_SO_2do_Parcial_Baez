Primero, cloné el repositorio y me moví al directorio de trabajo. Ejecuté un script de precondición para dejar todo listo:

git clone https://github.com/upszot/UTN-FRA_SO_Examenes.git
cd UTN-FRA_SO_Examenes/202406
./script_Precondicion.sh
Después, actualicé la lista de paquetes e instalé Git, asegurándome de que el sistema estuviera actualizado:

sudo apt update
sudo apt install git
Una vez que tenía Git, revisé los discos conectados al servidor y particioné el de 2GB (/dev/sdc) y el de 1GB (/dev/sdd):

sudo fdisk -l
sudo fdisk /dev/sdc
sudo fdisk /dev/sdd
Luego, creé los volúmenes físicos en las particiones para poder usarlas en LVM:

sudo pvcreate /dev/sdc1
sudo pvcreate /dev/sdc2
sudo pvcreate /dev/sdd1
Creé el grupo de volúmenes vg_datos con las particiones del disco de 2GB y lo extendí:

sudo vgcreate vg_datos /dev/sdc1
sudo vgextend vg_datos /dev/sdc2
También armé el grupo de volúmenes vg_temp con la partición del disco de 1GB:

sudo vgcreate vg_temp /dev/sdd1
Después de tener los grupos listos, pasé a crear los volúmenes lógicos. Configuré el volumen lógico lv_docker de 5MB en vg_datos y lo monté en /var/lib/docker:

sudo lvcreate -L 5M -n lv_docker vg_datos
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker/
Para el área de trabajo de los desarrolladores, creé lv_workareas de 1.5GB y lo monté en /work:

sudo lvcreate -L 1.5G -n lv_workareas vg_datos
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas
sudo mkdir /work
sudo mount /dev/mapper/vg_datos-lv_workareas /work/
Por último, configuré el volumen lógico de lv_swap de 512MB en vg_temp y lo activé como swap:

sudo lvcreate -L 512M -n lv_swap vg_temp
sudo mkswap /dev/mapper/vg_temp-lv_swap
sudo swapon /dev/mapper/vg_temp-lv_swap
