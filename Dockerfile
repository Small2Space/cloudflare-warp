FROM rockylinux:9.3-minimal

RUN dnf update
RUN dnf install -y curl
RUN curl -fsSl https://pkg.cloudflareclient.com/cloudflare-warp-ascii.repo | sudo tee /etc/yum.repos.d/cloudflare-warp.repo 
RUN dnf update
RUN dnf install -y cloudflare-warp
COPY run.sh /scripts
CMD ["sh","/scripts/run.sh"]
    
