server {
  server_name  www.pinkpolygon.com pinkpolygon.com;
  access_log  /var/log/nginx/pinkpolygon.com.access.log;
  error_log  /var/log/nginx/pinkpolygon.com.error.log;
  location  / {
    root  /var/www/pinkpolygon.com;
    index  index.html index.htm;
  }


    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/pinkpolygon/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/pinkpolygon/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}

server {
    if ($host = www.pinkpolygon.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = pinkpolygon.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


  listen  80;
  server_name  www.pinkpolygon.com pinkpolygon.com;
    return 404; # managed by Certbot




}