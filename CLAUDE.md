# Learner to Driver

Rails PWA with quizzes to get you ready for the SA learners test. Rails 8.1 / Ruby 4.0.5 / SQLite / Hotwire (Turbo + Stimulus).
Assets are bundled with **bun** (`bun.config.js`) + **dart-sass**, not importmap.

## Commands

```bash
bin/dev                      # Rails server + bun JS watch + sass watch (Procfile.dev)
bin/rails test               # full suite (Minitest, parallelized)
bin/rails test test/models/quiz_test.rb
bin/rubocop -a               # lint (must pass before committing)
bin/brakeman --no-pager
bin/setup                    # install deps + db:prepare + start server
bin/jobs                     # Solid Queue worker (Procfile.dev `worker`)
```

## Architecture

### Business logic lives in light-service, not controllers or models
Controllers stay thin: load the record, call an organizer, branch on `result.success?`.
Models hold associations, validations, enums, scopes, and small query/predicate helpers only.

```
app/actions/<domain>/<verb_noun>.rb      # single-responsibility LightService::Action
app/organizers/<domain>/<verb>.rb        # LightService::Organizer, composes actions
```

Namespaces mirror directories (`Evaluations::CreateEvaluation` → `app/actions/evaluations/create_evaluation.rb`).

**Organizer template** — explicit keyword args on `call`, actions listed in `self.actions`:

```ruby
class Evaluations::InitializeEvaluation
  extend ::LightService::Organizer

  def self.call(user:, quiz:)
    with(user:, quiz:).reduce(actions)
  end

  def self.actions
    [
      Evaluations::FindUserInProgressEvaluation,
      reduce_if(->(ctx) { ctx.evaluation.blank? }, [Evaluations::CreateEvaluation]),
    ]
  end
end
```

**Action template** — declare the contract with `expects`/`promises`, then `executed do |ctx|`:

```ruby
class Evaluations::CreateEvaluation
  extend ::LightService::Action

  expects :user, :quiz, :evaluation

  executed do |ctx|
    ctx.evaluation = ctx.user.evaluations.create!(
      quiz:       ctx.quiz,
      score:      0,
      status:     :started,
      started_at: DateTime.now
    )
  end
end
```

Notes on the style:
- `ctx.evaluation = ...` / `ctx.evaluation` — `LightService::Context` supports method-style access to keys.
- `expects :user, :quiz` fails loudly if a key is missing; `promises :evaluation` declares what the action sets.
- Use `next` to skip the rest of the block (`next unless ctx.evaluation.started?`).
- Fail with `next ctx.fail_and_return!(message: ...)`.
- `reduce_if(->(ctx) { ... }, [Actions])` conditionally runs actions in an organizer.
- Prefix cross-namespace constants with `::` to avoid resolving inside the current namespace.

### Controllers
- `ApplicationController` includes `Authentication`; auth is opt-out via `allow_unauthenticated_access`.
- `Current` (`app/models/current.rb`) holds `session` and delegates `user`.
- Admin controllers inherit from `AdminController` (`before_action :authenticate_admin`, `layout 'admin'`).
- Layouts: `user`, `guest`, `admin`, `registrations` — each fills `content_for` blocks and renders `layouts/application`.
- Strong params in a private `<model>_params` method at the bottom of the class.
- Authentication is Rails 8's built-in generator (session-based, `has_secure_password`) — not Devise or a third-party gem.

### Authorization
`action_policy` — policies in `app/policies`, `ApplicationPolicy < ActionPolicy::Base`. `ApplicationController` calls `authorize :user, through: -> { Current.user }`.

### View components
ViewComponent + ViewComponentContrib + Dry::Initializer. Components live in `app/components/<namespace>/<name>/component.rb` + `component.html.erb`, inherit from `ApplicationViewComponent < ViewComponentContrib::Base`.

```ruby
class Utils::InlineSvg::Component < ApplicationViewComponent
  option :path, required: true

  def svg_content
    file = Rails.root.join('app/assets/images/svg', path).cleanpath
    raise ArgumentError, "SVG not found: #{path}" unless file.exist?

    file.read
  end
end
```

- `option` uses Dry::Initializer — declare every initializer keyword arg with `option`:
  - `option :name, required: true` for required args (fails loudly if missing).
  - `option :name, default: -> { ... }` for optional args with defaults.
  - Aligned like the surrounding block, e.g.:

    ```ruby
    option :item,     required: true
    option :stimulus, default: -> { true }
    option :writable, default: -> { true }
    ```
- `stimulus_id` derives a Stimulus controller id from the class name; components pair with a colocated `controller.js` (e.g. `app/components/utils/date_time/controller.js`), registered in `app/components/controllers/index.js`.
- `component(name, ...)` / `collection_component(name, ...)` helpers render nested components.
- `MarkdownRenderable` (redcarpet + liquid) is included in `ApplicationViewComponent` and `ApplicationHelper`.

### Background jobs & caching
Rails 8 Solid stack: Solid Queue (jobs, `bin/jobs`), Solid Cache (caching), Solid Cable (websockets/Turbo Streams). No external Redis/Sidekiq dependency. MissionControl::Jobs is mounted at `/admin/jobs`.

## Environment

Required env vars grow as integrations are added — when you add one, document it here with what it's for (see `env.example`):

- `DB_PATH` — production SQLite path (default `storage`).
- `POSTMARK_API_TOKEN` — Postmark for transactional mail.
- `APP_URL` — canonical app URL.
- `RAILS_MASTER_KEY` — credentials key.

## Deployment

Dockerfile-based (standard Rails 8 Dockerfile + `bin/docker-entrypoint`). `db:prepare` runs on container start.

## Linting

`bin/rubocop -a` must pass before committing. Non-default cop settings live in `.rubocop.yml` (see especially `Layout/HashAlignment`, `TrailingCommaInArrayLiteral`, and the enabled rails/capybara/factory_bot plugins) — check it directly rather than assuming defaults. `.rubocop_todo.yml` holds pre-existing offenses; don't add to it.

## Conventions

- `# frozen_string_literal: true` at the top of every Ruby file.
- **Aligned hash values and assignments** (RuboCop `EnforcedColonStyle: table`) — match the surrounding block's alignment when editing.
- **Reach for current Ruby 4 / Rails 8 syntax** — see below.
- Enums are always `enum :status, { ... }, validate: true`, declared near the top of the model, with matching short scopes (`scope :with_questions, -> { joins(:questions).distinct }`).
- Model layout order: enums → associations → attachments → validations → scopes → public methods → `private`.
- Compact class/module nesting where RuboCop allows (`Style/ClassAndModuleChildren: compact`), but light-service files use explicit nested `module`s.
- Commit messages: `feat:` / `chore:` / `fix:` prefix, lowercase, imperative.

### Modern syntax to prefer

| Prefer | Over |
|---|---|
| `with(user:, quiz:)` (value omission) | `with(user: user, quiz: quiz)` |
| `params.expect(:id)` / `params.expect(quiz: [:title])` | `params.require(:id).permit(...)` |
| `status: :unprocessable_content` | `:unprocessable_entity` |
| `enum :status, { ... }, validate: true` | positional/keyword-less enum forms |
| `normalizes :email_address, with: ->(e) { e.strip.downcase }` | `before_save` normalization callbacks |

## Testing

Minitest + FactoryBot + Faker + shoulda-matchers + SimpleCov. Tests live in `test/`, mirroring `app/` (`test/models`, `test/actions`, `test/organizers`, `test/components`, `test/system`).

- `test_helper.rb` enables parallel testing (`parallelize(workers: :number_of_processors)`) and deletes the per-worker test databases (`db/test.sqlite3_0`, …) at exit.
- Factories define realistic Faker defaults plus named traits; use traits instead of inline attribute soup.
- Action tests call `Choices::CalculateScore.execute(choice:)` and assert on the persisted record.
- Organizer tests call `Evaluations::InitializeEvaluation.call(user:, quiz:)` and assert on `result[:evaluation]`.
- Component tests use `render_inline(Utils::InlineSvg::Component.new(path: 'icons/address.svg'))` and assert on the returned Nokogiri document.
- System tests use Cuprite (Chromium) via `ApplicationSystemTestCase`.
- Reload records before asserting on persisted changes (`choice.reload`).

## Gotchas

- `app/actions/evaluations/prepare_update_attributes.rb` still passes `ctx.params` around — prefer explicit named values for new actions.
- `.rubocop_todo.yml` holds existing offenses; don't add to it, fix new code instead.
- Test runs create `db/test.sqlite3_<n>` and `storage/test_solid_*.sqlite3_<n>` per parallel worker; `test_helper.rb` cleans them up at exit.
