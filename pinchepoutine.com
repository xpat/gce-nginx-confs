server {
  server_name  www.pinchepoutine.com pinchepoutine.com;
  access_log  /var/log/nginx/pinchepoutine.com.access.log;
  error_log  /var/log/nginx/pinchepoutine.com.error.log;
  location  / {
    root  /var/www/pinchepoutine.com;
    index  index.html index.htm;
  }


    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/pinchepoutine.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/pinchepoutine.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.pinchepoutine.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = pinchepoutine.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


  server_name  www.pinchepoutine.com pinchepoutine.com;
    listen 80;
    return 404; # managed by Certbot




}