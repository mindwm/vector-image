CMD ["bash"]
RUN RUN apt-get update  \
	&& apt-get install -y --no-install-recommends ca-certificates tzdata systemd  \
	&& rm -rf /var/lib/apt/lists/* # buildkit
COPY /usr/bin/vector /usr/bin/vector # buildkit
	usr/
	usr/bin/
	usr/bin/vector

COPY /usr/share/vector /usr/share/vector # buildkit
	usr/

COPY /usr/share/doc/vector /usr/share/doc/vector # buildkit
	usr/

COPY /etc/vector /etc/vector # buildkit
	etc/
	etc/vector/
	etc/vector/examples/
	etc/vector/examples/docs_example.yaml
	etc/vector/examples/environment_variables.yaml
	etc/vector/examples/es_s3_hybrid.yaml
	etc/vector/examples/file_to_cloudwatch_metrics.yaml
	etc/vector/examples/file_to_prometheus.yaml
	etc/vector/examples/prometheus_to_console.yaml
	etc/vector/examples/stdio.yaml
	etc/vector/examples/wrapped_json.yaml
	etc/vector/vector.yaml

COPY /var/lib/vector /var/lib/vector # buildkit
	var/
	var/lib/
	var/lib/vector/

RUN vector --version # buildkit
ENTRYPOINT ["/usr/bin/vector"]
ARG LUA_VERSION=5.4
ARG LUA_VERSION_MINOR=3
ARG LUA_ROCKS_VERSION=3.9
ARG LUA_ROCKS_VERSION_MINOR=2
RUN |4 LUA_VERSION=5.4 LUA_VERSION_MINOR=3 LUA_ROCKS_VERSION=3.9 LUA_ROCKS_VERSION_MINOR=2 RUN apt-get update # buildkit
RUN |4 LUA_VERSION=5.4 LUA_VERSION_MINOR=3 LUA_ROCKS_VERSION=3.9 LUA_ROCKS_VERSION_MINOR=2 RUN apt-get install -y curl make build-essential libreadline-dev git unzip # buildkit
WORKDIR /tmp
RUN |4 LUA_VERSION=5.4 LUA_VERSION_MINOR=3 LUA_ROCKS_VERSION=3.9 LUA_ROCKS_VERSION_MINOR=2 RUN curl -R -O -L http://www.lua.org/ftp/lua-$LUA_VERSION.$LUA_VERSION_MINOR.tar.gz  \
	&& tar zxvf lua-$LUA_VERSION.$LUA_VERSION_MINOR.tar.gz  \
	&& cd lua-$LUA_VERSION.$LUA_VERSION_MINOR  \
	&& make linux test  \
	&& make install # buildkit
WORKDIR /tmp
RUN |4 LUA_VERSION=5.4 LUA_VERSION_MINOR=3 LUA_ROCKS_VERSION=3.9 LUA_ROCKS_VERSION_MINOR=2 RUN curl -R -O -L https://luarocks.github.io/luarocks/releases/luarocks-$LUA_ROCKS_VERSION.$LUA_ROCKS_VERSION_MINOR.tar.gz  \
	&& tar zxvf luarocks-$LUA_ROCKS_VERSION.$LUA_ROCKS_VERSION_MINOR.tar.gz  \
	&& cd luarocks-$LUA_ROCKS_VERSION.$LUA_ROCKS_VERSION_MINOR  \
	&& ./configure --lua-version=${LUA_VERSION}  \
	&& make  \
	&& make install # buildkit
WORKDIR /tmp
RUN |4 LUA_VERSION=5.4 LUA_VERSION_MINOR=3 LUA_ROCKS_VERSION=3.9 LUA_ROCKS_VERSION_MINOR=2 RUN git clone https://github.com/yangxikun/opentelemetry-lua  \
	&& cd opentelemetry-lua  \
	&& luarocks make # buildkit
RUN |4 LUA_VERSION=5.4 LUA_VERSION_MINOR=3 LUA_ROCKS_VERSION=3.9 LUA_ROCKS_VERSION_MINOR=2 RUN luarocks install uuid  \
	&& luarocks install luasocket # buildkit


