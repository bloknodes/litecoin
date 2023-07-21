FROM bloknodes/base-nodes:litecoin-0.21.2.1

ENV NETWORK=testnet

COPY bin/run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh

COPY configs/mainnet.conf /etc/litecoin/mainnet.conf
COPY configs/testnet.conf /etc/litecoin/testnet.conf

CMD ["/usr/bin/run.sh"]