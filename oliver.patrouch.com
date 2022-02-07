server {
    root /var/www/lance.patrouch.com;
    index  index.php index.html index.htm;
    server_name  lance.patrouch.com;
    access_log /var/log/nginx/lancepatrouchcom.access.log;
    error_log /var/log/nginx/lancepatrouchcom.error.log;



    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/lance.patrouch.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/lance.patrouch.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = lance.patrouch.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name  lance.patrouch.com;
    return 404; # managed by Certbot


}