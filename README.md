# 🚀 Rails 8 Sandbox

A **Rails 8** application sandbox built for experimentation and rapid prototyping with the latest Ruby 3.4.6 runtime.  

Includes Hotwire, Turbo Drive / Streams, Stimulus JS, and an up-to-date Docker-Compose stack for local development.

---

## 🧱 Ruby & Framework Versions

| Component | Version |
|------------|----------|
| Ruby       | **3.4.6** |
| Rails      | **8.x** |
| Node.js    | **22 LTS** |
| PostgreSQL | **16** |
| Redis      | **7 Alpine** |

---

## ⚙️ System Dependencies

If you’re not using Docker, ensure you have the following installed locally:

- **Ruby 3.4.6** — via rbenv / rvm / asdf
- **PostgreSQL ≥ 14**
- **Redis ≥ 6.2**
- **Node.js 22 LTS** (for asset builds)
- **Yarn** or **Corepack** (for managing JS packages)
- **libvips** (image processing for Active Storage)

For Docker users, everything is preconfigured in `Dockerfile` + `docker-compose.yml` using an Ubuntu 24.04 LTS base image.

---

## 🧩 Configuration

1. **Clone the repository**
```bash
  git clone https://github.com/yourusername/rails8-hotwire-sandbox.git
  cd rails8-hotwire-sandbox
```

2. **Set up environment variables**
```bash
  cp .env.example .env
```

3. **(Optional) Run in Docker**
```bash 
  docker compose up -d --build
```

4. **Local setup (without Docker)**
```bash
  bundle install
  yarn install
  bin/rails db:prepare
```


## 🗄️ Database Creation
```bash
bin/rails db:create
```


## 🧮 Database Initialization
```bash
bin/rails db:migrate
bin/rails db:seed
```

## 🧪 How to Run the Test Suite
This project uses RSpec
```bash
# RSpec example
bundle exec rspec

# Minitest example
bin/rails test
```

For system tests (with Hotwire / Turbo):
```bash
bin/rails test:system
```

## 🧰 Services

| Service           | Purpose                 | Port   |
| ----------------- | ----------------------- | ------ |
| Web App (Rails 8) | Main application        | `3000` |
| PostgreSQL        | Database                | `5432` |
| Redis             | Cache / Background jobs | `6379` |

```bash
docker compose up
```

## 🚀 Deployment Instructions
### Using Kamal (Recommended)

1. Ensure you have a production server reachable via SSH.

2. Configure deployment:

```bash 
cp kamal.yml.example kamal.yml
# edit with your server, registry, and image details
```


3. Push secrets securely (do not commit kamal/secrets):

```bash
kamal env push
```

4. Deploy:

```bash
kamal deploy
```

### Manual (Heroku)

- Configure environment variables (RAILS_MASTER_KEY, DATABASE_URL, REDIS_URL).

- Build assets:

```bash
rails assets:precompile
```

- Run migrations:

```bash 
rails db:migrate
```

- Start the web process:

```bash
bin/rails server -e production
```

## 🧭 Project Structure Overview

```bash
app/
  controllers/
  models/
  views/
  javascript/
  channels/
config/
  database.yml
  environments/
docker-compose.yml
Dockerfile
```

## 💡 Notes
- This repo is for Hotwire + Rails 8 experiments: Turbo Drive, Turbo Streams, and Stimulus.

- Ideal for testing next-gen Rails 8 defaults such as Solid Queue, Propshaft, and new config defaults.

- Avoid committing sensitive files:

```bash
.env
kamal/secrets
kamal/secrets.*
```


## 📜 License

MIT License © 2025
