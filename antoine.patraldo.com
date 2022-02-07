server {
    server_name antoine.patraldo.com;
    access_log  /var/log/nginx/antoine.patraldo.com.access.log;
    error_log  /var/log/nginx/antoine.patraldo.com.error.log;
    location  / {
     root /var/www/antoine.patraldo.com;
     index index.html index.htm;
    }



    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/antoine.patraldo.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/antoine.patraldo.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = antoine.patraldo.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name antoine.patraldo.com;
    listen 80;
    return 404; # managed by Certbot


}