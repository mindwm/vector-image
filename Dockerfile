FROM timberio/vector:0.38.0-debian
ARG LUA_VERSION=5.4
ARG LUA_VERSION_MINOR=3
ARG LUA_ROCKS_VERSION=3.9
ARG LUA_ROCKS_VERSION_MINOR=2
RUN apt-get update # buildkit
RUN apt-get install -y curl make build-essential libreadline-dev git unzip # buildkit
WORKDIR /tmp
RUN curl -R -O -L http://www.lua.org/ftp/lua-$LUA_VERSION.$LUA_VERSION_MINOR.tar.gz  \
	&& tar zxvf lua-$LUA_VERSION.$LUA_VERSION_MINOR.tar.gz  \
	&& cd lua-$LUA_VERSION.$LUA_VERSION_MINOR  \
	&& make linux test  \
	&& make install
WORKDIR /tmp
RUN curl -R -O -L https://luarocks.github.io/luarocks/releases/luarocks-$LUA_ROCKS_VERSION.$LUA_ROCKS_VERSION_MINOR.tar.gz  \
	&& tar zxvf luarocks-$LUA_ROCKS_VERSION.$LUA_ROCKS_VERSION_MINOR.tar.gz  \
	&& cd luarocks-$LUA_ROCKS_VERSION.$LUA_ROCKS_VERSION_MINOR  \
	&& ./configure --lua-version=${LUA_VERSION}  \
	&& make  \
	&& make install
WORKDIR /tmp
RUN git clone https://github.com/yangxikun/opentelemetry-lua  \
	&& cd opentelemetry-lua  \
	&& luarocks make
RUN luarocks install uuid  \
	&& luarocks install luasocket


