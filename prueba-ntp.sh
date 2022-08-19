#!/bin/bash
#
#prueba-ntp.sh
# Version : 1.0
#Para validar el servicioi de sincronicado de tiempo y aviso a telegram si  servicio no disponible
#Autor : Ing. Jorge Navarrete
#mail : jorge_n@web.de
#Fecha : 2019-10-02

#prueba-ntp.sh
#Para validar el servicioi de sincronicado de tiempo y aviso a telegram si  servicio no disponible
#
#===========================================================================
PATH=/bin:/usr/bin:/usr/sbin/
#===========================================================================

echo ""
echo ""
echo "===========Inicio de prueba================"
echo ""
echo ""

#CADENA0="`curl --request POST \
#  --url http://10.1.14.211:8080/informaciondinardap/registrocivil/consultar \
#  --header 'Content-Type: application/xml' \
#  --header 'Postman-Token: 1226ae59-11af-4c3b-a734-139e25369703' \
#  --header 'cache-control: no-cache' \
#  --data '<RegistroCivilRequest>\n    <cedula>1709546541</cedula>\n</RegistroCivilRequest>'`"

CADENA="`/usr/sbin/ntpdate -u inocar.ntp.ec`"
HOST="`hostname`"
echo ""
echo ""

ESTADO1="adjust time server"
ESTADO2=""

if echo "$CADENA" | grep -q "$ESTADO1"; then
    echo "Servicio online";
elif echo "$CADENA" | grep -q "$ESTADO2"; then

        TOKEN="569774679:AAEl8uSwPNDzHwM_MCCR1-iXi4C6zLGeoqU"
        ID="152054272"
        IDP="63122379"
        MENSAJE="Servicio NTP   NO DISPONIBLE, problemas para sincronizar   $HOST                                      .";
        MERGE="$MENSAJE$CADENA"
        URL="https://api.telegram.org/bot$TOKEN/sendMessage"
        curl -s -X POST $URL -d chat_id=$ID -d text="$MENSAJE"  > /dev/null
#       curl -s -X POST $URL -d chat_id=$IDP -d text="$MENSAJE"  > /dev/null
        echo $MERGE | mail -s "Servicio NTP  NO DISPONIBLE!!!"  entidad.certificacion@funcionjudicial.gob.ec
#       echo $MERGE | mail -s "Servicio DINARDAP  NO DISPONIBLE!!!"  Despliegue@funcionjudicial.gob.ec
else
    echo "ERROR de ejecucion";
        TOKEN="569774679:AAEl8uSwPNDzHwM_MCCR1-iXi4C6zLGeoqU"
        ID="152054272"
        MENSAJE1="ERROR de ejecucion prueba-ntp.sh  $HOST                                  .";
        MERGE1="$MENSAJE1$CADENA"
        URL="https://api.telegram.org/bot$TOKEN/sendMessage"
        curl -s -X POST $URL -d chat_id=$ID -d text="$MERGE1"  > /dev/null

fi

echo ""
#echo "$CADENA"
echo ""
echo "===========Fin de prueba================"
echo ""

