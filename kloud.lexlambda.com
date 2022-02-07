server {
  listen  80; 
  server_name kloud.lexlambda.com;
  access_log  /var/log/nginx/kloud.lexlambda.access.log;
  error_log  /var/log/nginx/kloud.lexlambda.error.log;
  location  / {
    root /var/www/kloud.lexlambda.com;
        index index.html index.htm;
}
    listen 443 ssl; # managed by Certbot
ssl_certificate /etc/letsencrypt/live/lexlambda.com/fullchain.pem; # managed by Certbot
ssl_certificate_key /etc/letsencrypt/live/lexlambda.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot

ssl_dhparam /etc/ssl/certs/dhparam.pem;

    # Redirect non-https traffic to https
      if ($scheme != "https") {
      return 301 https://$host$request_uri;
      } # managed by Certbot
}
