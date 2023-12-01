# Use a base image (choose appropriate base image)
FROM ubuntu:latest

# Update system packages and install required dependencies
RUN apt-get update && apt-get install -y \
    postfix dovecot-imapd dovecot-pop3d dovecot-lmtpd \
    nginx supervisor wget ca-certificates

# Download iRedMail installation script
RUN wget https://github.com/iredmail/iRedMail/archive/1.4.1.tar.gz && \
    tar xvf 1.4.1.tar.gz && \
    rm 1.4.1.tar.gz

# Set working directory
WORKDIR /iRedMail-1.4.1/

# Run iRedMail installation script non-interactively (you may need to adjust this)
RUN bash iRedMail.sh

# Expose ports required by iRedMail
EXPOSE 25 80 110 143 443 465 587 993 995

# Add entrypoint script (if needed)
# ADD entrypoint.sh /

# Set entrypoint command
# ENTRYPOINT ["/entrypoint.sh"]

# Define command to start the services
CMD ["supervisord", "-n"]
