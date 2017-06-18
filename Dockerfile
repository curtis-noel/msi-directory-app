FROM rails:onbuild
ARG environment
ENV RAILS_ENV ${environment}
