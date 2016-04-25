FROM phpmanual/deps:latest

MAINTAINER Rogerio Prado de Jesus <rogeriopradoj@gmail.com>

ENV REPOSITORIES_PATH /php-manual-pt-br

RUN mkdir $REPOSITORIES_PATH

WORKDIR $REPOSITORIES_PATH

RUN svn checkout https://svn.php.net/repository/phpdoc/modules/doc-pt_BR

RUN git clone --depth=1 https://github.com/php/web-php.git

WORKDIR doc-pt_BR

RUN php doc-base/configure.php --enable-xml-details --with-lang=pt_BR \
    && phd --docbook doc-base/.manual.xml --package PHP --format php --output ../build/pt_BR

RUN php doc-base/configure.php --enable-xml-details \
    && phd --docbook doc-base/.manual.xml --package PHP --format php --output ../build/en

WORKDIR $REPOSITORIES_PATH

RUN [ -d `pwd`/web-php/manual/pt_BR ] && rm -r `pwd`/web-php/manual/pt_BR || true

RUN ln -s `pwd`/build/pt_BR/php-web `pwd`/web-php/manual/pt_BR

RUN [ -d `pwd`/web-php/manual/en ] && rm -r `pwd`/web-php/manual/en || true
    
RUN ln -s `pwd`/build/en/php-web `pwd`/web-php/manual/en
