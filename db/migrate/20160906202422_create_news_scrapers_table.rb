class CreateNewsScrapersTable < ActiveRecord::Migration[5.0]
  def up
    create_table :news_scrapers do |t|
      t.string :author, index: true
      t.text :body
      t.text :description
      t.text :keywords
      t.string :section
      t.datetime :datetime, index: true
      t.string :title, index: true
      t.string :root_domain, index: true
      t.timestamps
    end
  end 

  def down
    drop_table :news_scrapers
  end
end
