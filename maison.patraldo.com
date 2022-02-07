server {
    root /var/www/maison.patraldo.com/public;
    index index.html index.js;
    server_name maison.patraldo.com;
    access_log /var/log/nginx/maison.patraldo.com.access.log;
    error_log /var/log/nginx/maison.patraldo.com.error.log;




    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/maison.patraldo.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/maison.patraldo.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = maison.patraldo.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name maison.patraldo.com;
    listen 80;
    return 404; # managed by Certbot


}