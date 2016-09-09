class AddUriToNewsScrapers < ActiveRecord::Migration[5.0]
  def self.up
    add_column :news_scrapers, :uri, :string
    add_index :news_scrapers, :uri, unique: true
  end
  def self.down
    remove_index :news_scrapers, :uri
    remove_column :news_scrapers, :uri
  end
end
