org=$(echo $ORGANIZATION)
auth_id=$(echo $AUTH_CLIENT_ID)
auth_secret=$(echo $AUTH_CLIENT_SECRET)
token=$(echo $WARP_CONNECTOR_TOKEN)

path="/var/lib/cloudflare-warp/mdm.xml"

echo "<dict>" > $path
echo "<key>organization</key>" >> $path
echo "<string>$org</string>" >> $path
echo "<key>auth_client_id</key>" >> $path
echo "<string>$auth_id</string>" >> $path
echo "<key>auth_client_secret</key>" >> $path
echo "<string>$auth_secret</string>" >> $path
echo "<key>warp_connector_token</key>" >> $path
echo "<string>$token</string>" >> $path
echo "</dict>" >> $path

warp-svc
