FROM phpmanual/deps:latest

MAINTAINER Rogerio Prado de Jesus <rogeriopradoj@gmail.com>

RUN export REPOSITORIES_PATH="/php-manual-pt-br" && \
    rm -rf $REPOSITORIES_PATH && \
    mkdir $REPOSITORIES_PATH && \
    cd $REPOSITORIES_PATH && \
    \
    svn checkout https://svn.php.net/repository/phpdoc/modules/doc-pt_BR && \
    cd doc-pt_BR && \
    \
    php doc-base/configure.php --enable-xml-details --with-lang=pt_BR && \
    phd --docbook doc-base/.manual.xml --package PHP --format php --output ../build-pt-br && \
    \
    php doc-base/configure.php --enable-xml-details && \
    phd --docbook doc-base/.manual.xml --package PHP --format php --output ../build-en && \
    \
    cd $REPOSITORIES_PATH && \
    git clone --depth=1 https://github.com/php/web-php.git && \
    \
    [ -d `pwd`/web-php/manual/pt_BR ] && rm -r `pwd`/web-php/manual/pt_BR && \
    ln -s `pwd`/build-pt-br/php-web `pwd`/web-php/manual/pt_BR \
    \
    [ -d `pwd`/web-php/manual/en ] && rm -r `pwd`/web-php/manual/en && \
    ln -s `pwd`/build-en/php-web `pwd`/web-php/manual/en && \
    \
    true
