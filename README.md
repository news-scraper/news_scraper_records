# News Scrapers Records

ActiveRecord maintenance for news scrapers records

1. Make sure you have `dev` installed => `eval "$(curl -sS https://dev.shopify.io/up)"`
2. Run `dev up`

Production
---
- This will only work on master and when everything has been pushed to remote.
- Run `dev prod_sync` to synchronize production with the current state of master

Ejson
---
- `config/secrets/*.ejson` holds information for various environments. They will override the same environment specified by `config/database.yml`
- Environment can be set with `ENV=X`
