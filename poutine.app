server {
    root /var/www/poutine.app;
    index index.php index.html index.htm;
    server_name  poutine.app www.poutine.app;
    access_log /var/log/nginx/poutine.app.access.log;
    error_log /var/log/nginx/poutine.app.error.log;


    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/poutine.app/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/poutine.app/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.poutine.app) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = poutine.app) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name  poutine.app www.poutine.app;
    listen 80;
    return 404; # managed by Certbot




}