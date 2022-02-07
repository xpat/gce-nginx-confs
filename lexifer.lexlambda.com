server {
    root /var/www/lexifer.lexlambda.com/wpwebsite;
    index  index.php index.html index.htm;
    server_name  lexifer.lexlambda.com;

    client_max_body_size 500M;

    location / {
        try_files $uri $uri/ /index.php?$args;
    }
	
    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
        expires max;
        log_not_found off;
    }	

    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }	

    location ~ \.php$ {
         include snippets/fastcgi-php.conf;
         fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
         fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
         include fastcgi_params;
    }

    listen [::]:443 ssl; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/lexifer.lexlambda.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/lexifer.lexlambda.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = lexifer.lexlambda.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    listen [::]:80;
    server_name  lexifer.lexlambda.com;
    return 404; # managed by Certbot


}
