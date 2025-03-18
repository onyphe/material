FROM alpine:latest
ARG CLI_VERSION=4.19.0
WORKDIR /onyphecli
RUN apk update && apk upgrade
RUN apk add --no-cache perl perl-dev make libssl3 libressl-dev openssl build-base zlib zlib-dev
RUN apk add --no-cache perl-app-cpanminus perl-net-ssleay
RUN cpanm -n Config::INI::Tiny Text::ParseWords Net::IPv4Addr Regexp::IPv4 
RUN cpanm -n Mojolicious Tie::IxHash LWP::Protocol::https JSON::XS File::Slurp Text::CSV_XS Regexp::IPv6
RUN echo 'api_endpoint = https://www.onyphe.io/api/v2' > ~/.onyphe.ini 
RUN echo 'api_key = XXXX' >> ~/.onyphe.ini 
ADD ./Onyphe-v$CLI_VERSION.tar.gz . 
WORKDIR /onyphecli/Onyphe-v$CLI_VERSION
RUN perl ./Build.PL
RUN ./Build test && ./Build install
WORKDIR /root
ENTRYPOINT ["onyphe"]
CMD ["-version"]
