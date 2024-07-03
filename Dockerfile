FROM ubuntu:24.10

RUN apt update -y

RUN apt install -y curl gpg

RUN curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg 

RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list 

RUN apt update -y && apt install -y cloudflare-warp

COPY run.sh /scripts
CMD ["sh","/scripts/run.sh"]
    
