server {
  server_name  www.hostedby.pinkpolygon.com hostedby.pinkpolygon.com;
  access_log  /var/log/nginx/hostedby.pinkpolygon.com.access.log;
  error_log  /var/log/nginx/hostedby.pinkpolygon.com.error.log;
  location  / {
    root  /var/www/hostedby.pinkpolygon.com;
    index  index.html index.htm;
  }



    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/hostedby.pinkpolygon.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/hostedby.pinkpolygon.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = hostedby.pinkpolygon.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


  server_name  www.hostedby.pinkpolygon.com hostedby.pinkpolygon.com;
    listen 80;
    return 404; # managed by Certbot


}