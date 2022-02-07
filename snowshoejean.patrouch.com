server {
    server_name snowshoejean.patrouch.com;
  access_log  /var/log/nginx/snowshoejean.patrouch.com.access.log;
  error_log  /var/log/nginx/snowshoejean.patrouch.com.error.log;
  location  / {
 root /var/www/snowshoejean.patrouch.com/snowshoejean;
           index index.html index.htm;
}



    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/snowshoejean.patrouch.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/snowshoejean.patrouch.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = snowshoejean.patrouch.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name snowshoejean.patrouch.com;
    listen 80;
    return 404; # managed by Certbot


}
