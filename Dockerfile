FROM rockylinux:9.3-minimal

RUN microdnf update -y
RUN microdnf install -y curl
RUN curl -fsSl https://pkg.cloudflareclient.com/cloudflare-warp-ascii.repo | sudo tee /etc/yum.repos.d/cloudflare-warp.repo 
RUN microdnf update -y
RUN microdnf install -y cloudflare-warp
COPY run.sh /scripts
CMD ["sh","/scripts/run.sh"]
    
