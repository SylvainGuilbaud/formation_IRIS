FROM postgres:14.5

RUN sed -i 's/$/ 9.6/' /etc/apt/sources.list.d/pgdg.list

RUN apt-get update && apt-get install -y --no-install-recommends \
		postgresql-9.6=9.6.24-3.pgdg110+1 \
		postgresql-contrib-9.6=9.6.24-3.pgdg110+1 \
	&& rm -rf /var/lib/apt/lists/*

ENV PGBINOLD /usr/lib/postgresql/9.6/bin
ENV PGBINNEW /usr/lib/postgresql/14/bin

ENV PGDATAOLD /var/lib/postgresql/9.6/data
ENV PGDATANEW /var/lib/postgresql/14/data

RUN mkdir -p "$PGDATAOLD" "$PGDATANEW" \
	&& chown -R postgres:postgres /var/lib/postgresql

WORKDIR /var/lib/postgresql

COPY docker-upgrade /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-upgrade

ENTRYPOINT ["docker-upgrade"]

CMD ["pg_upgrade"]
