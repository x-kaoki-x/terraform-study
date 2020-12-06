FROM hashicorp/terraform:0.12.0
WORKDIR /terraform/staging

ADD ./staging /terraform/staging
ADD ./modules /terraform/modules
RUN terraform get

ENTRYPOINT [""]
CMD ["/bin/sh"]