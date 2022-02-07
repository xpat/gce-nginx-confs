server {
    server_name jenkins.cpidms.com;
  access_log  /var/log/nginx/jenkins.cpidms.com.access.log;
  error_log  /var/log/nginx/jenkins.cpidms.com.error.log;
  location  / {
 root /var/www/jenkins.cpidms.com;
           index index.html index.htm;
}


    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/jenkins.cpidms.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/jenkins.cpidms.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
    
server {
    if ($host = jenkins.cpidms.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name jenkins.cpidms.com;
    listen 80;
    return 404; # managed by Certbot


}