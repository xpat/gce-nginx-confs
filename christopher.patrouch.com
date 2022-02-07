server {
    server_name christopher.patrouch.com;
  access_log  /var/log/nginx/christopher.patrouch.com.access.log;
  error_log  /var/log/nginx/christopher.patrouch.com.error.log;
  location  / {
    root /var/www/christopher.patrouch.com;
     index  index.html index.htm;
}

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/christopher.patrouch.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/christopher.patrouch.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = christopher.patrouch.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name christopher.patrouch.com;
    return 404; # managed by Certbot


}
