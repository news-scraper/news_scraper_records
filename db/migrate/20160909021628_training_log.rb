class TrainingLog < ActiveRecord::Migration[5.0]
  def up
    create_table :training_logs do |t|
      t.string :root_domain, unique: true, index: true
      t.text :uris, array: true, default: []
      t.integer :trained_status, default: 0, index: true
      t.timestamps
    end

    add_index :training_logs, [:root_domain, :trained_status]
  end 

  def down
    drop_table :training_logs
  end
end
