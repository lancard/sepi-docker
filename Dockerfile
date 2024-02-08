FROM ubuntu

RUN ulimit -c unlimited
RUN apt-get update
RUN apt-get install locales gcc make net-tools vim telnet ftp file wget git cron openssh-server -y
RUN apt-get upgrade -y
RUN localedef -i ko_KR -c -f UTF-8 -A /usr/share/locale/locale.alias ko_KR.UTF-8
ENV LANG ko_KR.UTF-8
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

RUN echo "0 1 * * * cd /sepi && ./backscr" > crontab.txt
RUN echo "0 2 * * * apt-get update && apt-get upgrade -y" >> crontab.txt
RUN cat crontab.txt | crontab -

COPY --chmod=755 docker-entrypoint.sh /

WORKDIR /sepi

ENTRYPOINT /docker-entrypoint.sh
