server {
    server_name www.mexicanbold.com mexicanbold.com;
    access_log  /var/log/nginx/mexicanbold.com.access.log;
    error_log  /var/log/nginx/mexicanbold.com.error.log;
    location  / {
     root /var/www/mexicanbold.com/export;
     index index.html index.htm;
    }


    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/mexicanbold.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/mexicanbold.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.mexicanbold.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = mexicanbold.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name www.mexicanbold.com mexicanbold.com;
    listen 80;
    return 404; # managed by Certbot




}
