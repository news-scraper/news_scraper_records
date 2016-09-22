class CreateDomainEntriesTable < ActiveRecord::Migration[5.0]
  def self.up
    create_table :domain_entries do |t|
      t.string :key
      t.string :method
      t.string :pattern
      t.integer :domain_id, null: false
      t.timestamps
    end
    add_foreign_key :domain_entries, :domains
  end

  def self.down
    remove_foreign_key :domain_entries, :domains
    drop_table :domain_entries
  end
end
