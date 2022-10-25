FROM python:3.6-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk add --no-cache gcc g++ musl-dev make libc-dev linux-headers pcre-dev \
       libxslt-dev openssl-dev jpeg-dev zlib-dev
WORKDIR /app
ADD requirements.txt ./
RUN pip install -r requirements.txt -i https://pypi.douban.com/simple
ADD yiban_web.tar.gz /
RUN mv /yiban_web/* /app
ADD docker-entrypoint.sh ./
RUN chmod +x /app/docker-entrypoint.sh
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update && apk add ca-certificates &&  update-ca-certificates\
    && apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/*
EXPOSE 8001
VOLUME /app/
ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:80"]
