FROM lachlanevenson/k8s-helm:v3.6.0
FROM lachlanevenson/k8s-kubectl:v1.20.7
FROM hashicorp/terraform:1.0.5

FROM ubuntu:20.04

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip \
  && pip3 --no-cache-dir install awscli==1.16.266 ansible==2.10.5


COPY --from=0 /usr/local/bin/helm /usr/local/bin/helm
COPY --from=1 /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=2 bin/terraform /usr/local/bin/terraform



ENTRYPOINT ["/usr/local/bin/terraform"]









