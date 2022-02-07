server {
    server_name cpidms.com www.cpidms.com;
  access_log  /var/log/nginx/cpidms.com.access.log;
  error_log  /var/log/nginx/cpidms.com.error.log;
  location  / {
 root /var/www/cpidms.com/climaloca/web;
           index index.html index.htm;
}
    

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/cpidms.com-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/cpidms.com-0001/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.cpidms.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = cpidms.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name cpidms.com www.cpidms.com;
    return 404; # managed by Certbot




}
