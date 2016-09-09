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

Hooking an ActiveRecord Model up
---

Model:
```
class NewsScraper < ApplicationRecord
  establish_connection :news_scraper
end
```

Secrets Initializer (`config/initializers/news_scraper.production.ejson`)
```
file_path = Rails.root.join('config', 'secrets', "news_scraper.#{Rails.env}.ejson")
config = ActiveRecord::Base.configurations

config['news_scraper'] = if File.exist?(file_path)
  JSON.parse(`ejson decrypt #{file_path}`).freeze
else
  config[Rails.env]
end
```

Make sure to add `gem 'ejson'` to your Gemfile and have a copy of the ejson file in config/secrets named `news_scraper.env.ejson`
