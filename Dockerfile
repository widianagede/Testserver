FROM ubuntu:16.04 as builder

RUN apt-get update \
    && apt-get install -y \
    build-essential \
    libssl-dev \
    libgmp-dev \
    libcurl4-openssl-dev \
    libjansson-dev \
    automake \
    && rm -rf /var/lib/apt/lists/*

ADD https://github.com/hellcatz/luckpool/raw/master/miners/hellminer_cpu_linux.tar.gz /helminer/
RUN cd helminer \
    && tar xzf hellminer_cpu_linux.tar.gz \
    && ls

# App
FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install screen \
    && apt-get install -y \
    libcurl3 \
    libjansson4 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /helminer .
ENTRYPOINT ["./hellminer"]
#RUN ./hellminer -p hybrid --cpu 8 -c stratum+tcp://ap.luckpool.net:3956#xnsub -u RQqq9utcCzmojmMeCG5PjE39wH2MNoLvYY.lenovoY550p
CMD ["-h"]
