# =========================================================
# Base OS: Ubuntu 24.04 LTS
# =========================================================
FROM ubuntu:24.04

ENV LANG=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive \
    RUBY_VERSION=3.4.7

# =========================================================
# System dependencies
# =========================================================
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential \
      curl \
      git \
      ca-certificates \
      libssl-dev \
      libyaml-dev \
      libreadline-dev \
      zlib1g-dev \
      libncurses5-dev \
      libffi-dev \
      libgdbm-dev \
      libdb-dev \
      libpq-dev \
      postgresql-client \
      libvips \
      shared-mime-info \
      zsh \
      tzdata && \
    rm -rf /var/lib/apt/lists/*

# =========================================================
# Install Ruby 3.4.7 from source
# =========================================================
RUN mkdir -p /tmp/src && cd /tmp/src && \
    curl -fsSL https://cache.ruby-lang.org/pub/ruby/${RUBY_VERSION%.*}/ruby-${RUBY_VERSION}.tar.gz \
      -o ruby-${RUBY_VERSION}.tar.gz && \
    tar -xzf ruby-${RUBY_VERSION}.tar.gz && \
    cd ruby-${RUBY_VERSION} && \
    ./configure --disable-install-doc && \
    make -j"$(nproc)" && make install && \
    cd / && rm -rf /tmp/src

RUN gem install bundler --no-document

# =========================================================
# Node.js 22 LTS + Corepack (Yarn)
# =========================================================
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    corepack enable && corepack prepare yarn@stable --activate && \
    rm -rf /var/lib/apt/lists/*

# =========================================================
# Install Rails 8
# =========================================================
RUN gem install rails -v "~> 8.0" --no-document

# =========================================================
# App setup
# =========================================================
WORKDIR /app

# Copy and install dependencies (optional — uncomment if you have these files)
# COPY Gemfile Gemfile.lock ./
# RUN bundle config set without 'development test' && bundle install --jobs 4
# COPY package.json yarn.lock ./
# RUN yarn install --frozen-lockfile
# COPY . .

EXPOSE 3000

# Default command
CMD ["bash"]
