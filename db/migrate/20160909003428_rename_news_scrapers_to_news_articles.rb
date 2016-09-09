class RenameNewsScrapersToNewsArticles < ActiveRecord::Migration[5.0]
  def self.up
    rename_table :news_scrapers, :news_articles
  end
  def self.down
    rename_table :news_articles, :news_scrapers
  end
end
