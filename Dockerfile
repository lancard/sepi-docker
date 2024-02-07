FROM ubuntu

RUN ulimit -c unlimited
RUN apt-get update
RUN apt-get install locales gcc make net-tools vim telnet ftp file wget git cron -y
RUN apt-get upgrade -y
RUN localedef -i ko_KR -c -f UTF-8 -A /usr/share/locale/locale.alias ko_KR.UTF-8
ENV LANG ko_KR.UTF-8
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

WORKDIR /root
RUN wget https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_386.tar.gz
RUN tar xvzf gdrive_2.1.1_linux_386.tar.gz
RUN cp gdrive /sbin

RUN useradd -ms /bin/bash ubuntu
USER ubuntu
WORKDIR /home/ubuntu
RUN echo "0 1 * * * tar czf /home/ubuntu/sepi/backup/love.tar.gz /home" > crontab.txt
RUN echo "0 2 * * * gdrive sync upload ~/backup 1HRPcR2MNWfTbX8kkI6TudE1uwwaV6A8k --no-progress" >> crontab.txt
RUN echo "0 3 * * * apt-get update && apt-get upgrade -y" >> crontab.txt
RUN cat crontab.txt | crontab -

ENTRYPOINT ["tail", "-f", "/dev/null"]