# ABCLTDA
a Rails 7 boilerplate template by [@ryanckulp](https://twitter.com/ryanckulp), created to ship SaaS apps quickly. Learn how to use this at [24 Hour MVP](https://founderhacker.com/24-hour-mvp).

features:
* user authentication via [Devise](https://github.com/plataformatec/devise)
* design via [Tailwind UI](https://tailwindui.com/)
* safely manage ENV variables with [Figaro](https://github.com/laserlemon/figaro)
* responsive toggle navbar w/ logic for login, signup, settings
* SEO toolbelt via [metamagic](https://github.com/lassebunk/metamagic)
* increased debugging power with [Better Errors](https://github.com/charliesome/better_errors)
* seed your DB in seconds via [Seed Dump](https://github.com/rroblak/seed_dump)
* production-ready DB via Postgres

## Installation
1. clone the repo
1. `cd ABCLTDA && bundle` (installs dependencies)
2. `bundle exec figaro install`
3. `cp config/application-sample.yml config/application.yml` (put ENV vars here)
4. `rm -rf .git && git init && git add . && git commit -m 'first commit'` to remove git references to this repo and reinitialize git

## Development
```sh
bin/dev # uses foreman to boot server, frontend, and bg job queue
```

**troubleshooting**
`Turbo Drive` lazy-loads pages following form submission, causing script tags at the bottom of following views to not always load.

```html
<!-- add data-turbo=false to form submission buttons if the following view needs a full render -->
<button data-turbo="false" type="submit" ...>Submit</button>
```

## Testing
```
bundle exec rspec # run all tests inside spec/
bundle exec rspec spec/dir_name # run all tests inside given directory
```

## Miscellaneous
to use Postmark for emails, set `postmark_api_token` inside `application.yml`, then [verify your sending domain](https://account.postmarkapp.com/signature_domains/initialize_verification).
