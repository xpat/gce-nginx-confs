server {
    root /var/www/lexlambda.com/export;
    index  index.php index.html index.htm;
    server_name  lexlambda.com www.lexlambda.com;
    access_log /var/log/nginx/lexlambda.com.access.log;
    error_log /var/log/nginx/lexlambda.com.error.log;


    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/lexlambda.com-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/lexlambda.com-0001/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.lexlambda.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = lexlambda.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name  lexlambda.com www.lexlambda.com;
    listen 80;
    return 404; # managed by Certbot




}
