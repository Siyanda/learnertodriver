<div align="center">
  <br>
  <a href="https://learnertodriver.co.za/">
    <img
      alt="Learner to Driver"
      src="app/assets/images/favicon.png"
      width="100px"
    />
  </a>
  <br/>
  <h1>📚 📝 🚗</h1>
  <strong>Rails PWA with quizzes to get you ready for the SA learners test</strong>
</div>
<br/>
<p align="center">
  <a href="https://www.ruby-lang.org/en/">
    <img src="https://img.shields.io/badge/Ruby-v4.0.5-red.svg" alt="ruby version"/>
  </a>
  <a href="http://rubyonrails.org/">
    <img src="https://img.shields.io/badge/Rails-v8.1.3-red.svg" alt="rails version"/>
  </a>
  <a href="https://bun.sh/">
    <img src="https://img.shields.io/badge/bun-v1.3.11-red.svg" alt="bun version"/>
  </a>
</p>

## About

Learner to Driver is a Rails PWA that helps you prepare for the South African learner's licence test with interactive quizzes. It's built on Rails 8 with Hotwire (Turbo + Stimulus) and the Solid stack — no external Redis or Sidekiq required.

### Features

- Interactive quizzes with instant scoring and evaluations
- Study material via posts, comments, and tags
- PWA support: installable, offline-capable, with a service worker
- Admin dashboard for managing quizzes, questions, posts, and users
- Background jobs via Solid Queue, monitored with MissionControl::Jobs

## Tech stack

| Layer | Technology |
|---|---|
| Framework | Rails 8.1 |
| Language | Ruby 4.0.5 |
| Database | SQLite |
| Frontend | Hotwire (Turbo + Stimulus), bun + dart-sass |
| Background jobs | Solid Queue |
| Caching | Solid Cache |
| WebSockets | Solid Cable |
| Components | ViewComponent + ViewComponentContrib |
| Business logic | LightService |
| Authorization | ActionPolicy |
| Mail | Postmark |

## Getting Started

### Prerequisites

- [Ruby](https://www.ruby-lang.org/en/) 4.0.5 — we recommend [asdf](https://asdf-vm.com/) or [mise](https://mise.jdx.dev/)
- [bun](https://bun.sh/) 1.3.11
- [SQLite](https://www.sqlite.org/)

### Installation

1. Fork the repository: https://github.com/Siyanda/learnertodriver/fork
2. Clone your fork: `git clone https://github.com/<your-username>/learnertodriver.git`
3. Run the setup script — it installs Ruby and JS dependencies, prepares the database, and starts the dev server:

   ```sh
   bin/setup
   ```

   To set up without starting the server:

   ```sh
   bin/setup --skip-server
   ```

### Starting the application

```sh
bin/dev
```

`bin/dev` runs the `Procfile.dev` via overmind (or foreman): the Rails server, the bun JS watcher, the dart-sass watcher, and the Solid Queue worker.

## Testing

```sh
bin/rails test          # full suite (Minitest, parallelized)
bin/rails test test/models/quiz_test.rb
```

Tests use Minitest + FactoryBot + Faker + shoulda-matchers + SimpleCov. System tests run with Cuprite (Chromium).

## Linting

```sh
bin/rubocop -a          # auto-fix style offenses
bin/brakeman --no-pager # security scan
```

## Deployment

The app is Dockerized (standard Rails 8 Dockerfile). `db:prepare` runs on container start. See `Dockerfile` and `bin/docker-entrypoint`.

## Environment variables

See `env.example` for the full list. Key variables:

| Variable | Purpose |
|---|---|
| `DB_PATH` | Production SQLite path (default `storage`) |
| `POSTMARK_API_TOKEN` | Postmark for transactional mail |
| `APP_URL` | Canonical app URL |
| `RAILS_MASTER_KEY` | Credentials key |

## Project structure

- `app/actions/<domain>/<verb_noun>.rb` — single-responsibility LightService actions
- `app/organizers/<domain>/<verb>.rb` — LightService organizers composing actions
- `app/components/<namespace>/<name>/` — ViewComponents with colocated Stimulus controllers
- `app/policies/` — ActionPolicy authorization policies
- `app/controllers/admin/` — admin area (layout `admin`, `AdminController`)

## Contributing

1. Fork the repo and create a feature branch
2. Make your changes
3. Run `bin/rubocop -a` and the test suite
4. Open a pull request

<br/>

<p align="center">
  <br/>
  <strong>Enjoy</strong> ❤️
</p>
