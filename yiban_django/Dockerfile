FROM daocloud.io/library/python:3.6.3-stretch

WORKDIR /app
ADD requirements.txt ./
RUN pip install -r requirements.txt -i https://pypi.douban.com/simple
ADD yiban_web.tar.gz /
RUN mv /yiban_web/* /app
ADD docker-entrypoint.sh ./
RUN chmod +x /app/docker-entrypoint.sh
EXPOSE 8001
VOLUME /app/
ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:80"]
