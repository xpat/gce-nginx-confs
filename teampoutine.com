server {
    root  /var/www/teampoutine.com;
    index index.html;
    server_name teampoutine.com www.teampoutine.com;
    access_log  /var/log/nginx/teampoutine.com.access.log;
    error_log  /var/log/nginx/teampoutine.com.error.log;


    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/teampoutine.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/teampoutine.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.teampoutine.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = teampoutine.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name teampoutine.com www.teampoutine.com;
    listen 80;
    return 404; # managed by Certbot




}