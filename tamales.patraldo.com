server {
    root /var/www/tamales.patraldo.com;
    index  index.php index.html index.htm;
    server_name tamales.patraldo.com www.tamales.patraldo.com;
    access_log  /var/log/nginx/tamales.patraldo.com.access.log;
    error_log  /var/log/nginx/tamales.patraldo.com.error.log;



    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/tamales.patraldo.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/tamales.patraldo.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = tamales.patraldo.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name tamales.patraldo.com www.tamales.patraldo.com;
    listen 80;
    return 404; # managed by Certbot


}