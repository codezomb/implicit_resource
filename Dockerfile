FROM public.ecr.aws/docker/library/ruby:3.2

WORKDIR /work
COPY . ./
RUN bundle install

ENTRYPOINT ["/bin/bash", "-c"]
