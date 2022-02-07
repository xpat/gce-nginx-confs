server {
    root /var/www/patrouch.com/export;
    index  index.php index.html index.htm;
    server_name  patrouch.com www.patrouch.com;
    access_log /var/log/nginx/patrouch.com.access.log;
    error_log /var/log/nginx/patrouch.com.error.log;



    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/patrouch.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/patrouch.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.patrouch.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = patrouch.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name  patrouch.com www.patrouch.com;
    return 404; # managed by Certbot




}
