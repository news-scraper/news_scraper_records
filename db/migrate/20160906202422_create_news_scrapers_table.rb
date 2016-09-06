class CreateNewsScrapersTable < ActiveRecord::Migration[5.0]
  def up
    create_table :news_scrapers do |t|
      t.string :author
      t.text :body
      t.text :description
      t.text :keywords
      t.string :section
      t.datetime :datetime
      t.string :title
      t.string :root_domain
      t.timestamps
    end
  end 

  def down
    drop_table :news_scrapers
  end
end
