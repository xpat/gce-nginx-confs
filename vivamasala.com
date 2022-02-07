server {
    root /var/www/vivamasala.com;
    index  index.php index.html index.htm;
    server_name vivamasala.com www.vivamasala.com;
    access_log  /var/log/nginx/vivamasala.com.access.log;
    error_log  /var/log/nginx/vivamasala.com.error.log;



    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/www.vivamasala.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/www.vivamasala.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = vivamasala.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = www.vivamasala.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name vivamasala.com www.vivamasala.com;
    listen 80;
    return 404; # managed by Certbot




}