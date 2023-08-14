FROM ubuntu:22.04 AS base

    RUN apt-get update  \
       && apt-get -y remove g++ gcc \
       && apt-get -y install git wget \
       && rm -rf /var/lib/apt/lists/*
