# ABCLTDA

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

## Miscellaneous
to use Postmark for emails, set `postmark_api_token` inside `application.yml`, then [verify your sending domain](https://account.postmarkapp.com/signature_domains/initialize_verification).
