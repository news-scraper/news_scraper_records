class CreateDomainsTable < ActiveRecord::Migration[5.0]
  def self.up
    create_table :domains do |t|
      t.string :root_domain, null: false
      t.timestamps
    end
  end

  def self.down
    drop_table :domains
  end
end
