require_relative '../../environment'

class CreateNewsScrapersTable < ActiveRecord::Migration[5.0]
  def up
    create_table :news_scrapers do |t|
      t.integer :deck_id
      t.integer :study_session_id
    end
    puts 'ran up method'
  end 

  def down
    drop_table :news_scrapers
    puts 'ran down method'
  end
end

CreateNewsScrapersTable.migrate(ARGV[0])
