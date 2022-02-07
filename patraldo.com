server {
    server_name patraldo.com www.patraldo.com;
  access_log  /var/log/nginx/patraldo.com.access.log;
  error_log  /var/log/nginx/patraldo.com.error.log;
  location  / {
    root /var/www/patraldo.com;
     index  index.html index.htm;
}

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/patraldo.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/patraldo.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.patraldo.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = patraldo.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name patraldo.com www.patraldo.com;
    return 404; # managed by Certbot




}
