class TrainingLog < ActiveRecord::Migration[5.0]
  def up
    create_table :training_logs do |t|
      t.string :root_domain, index: true
      t.string :uri
      t.string :trained_status, default: 'untrained', index: true
      t.timestamps
    end

    add_index :training_logs, [:root_domain, :trained_status]
    add_index :training_logs, :uri, unique: true
  end 

  def down
    drop_table :training_logs
  end
end
