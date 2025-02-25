FROM ubuntu:22.04

RUN apt-get update
RUN apt-get upgrade -y 
RUN apt-get install -y curl gnupg lsb-release sudo

RUN curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg 

RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list 

RUN apt-get update
RUN apt-get install -y cloudflare-warp gpg supervisor

WORKDIR /scripts
COPY run.sh /scripts/run.sh
COPY supervisord.conf /etc/supervisor/supervisord.conf

RUN echo "[program:warp-svc]\ncommand=/bin/bash -c /usr/bin/warp-svc\nautostart=true\nautorestart=true\nstartretries=3\nstderr_logfile=/var/log/warp.log\nstdout_logfile=/var/log/warp.log\n" > /etc/supervisor/conf.d/warp.conf
RUN echo  "sh /scripts/run.sh\nsupervisord -c /etc/supervisor/supervisord.conf\nsleep 5\n"  > /init.sh && chmod +x /init.sh

CMD ["bash","-c","/init.sh"]
    
