FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends sudo

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["bash"]