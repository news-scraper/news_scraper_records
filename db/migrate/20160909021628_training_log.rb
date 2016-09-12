class TrainingLog < ActiveRecord::Migration[5.0]
  def up
    create_table :training_logs do |t|
      t.string :root_domain, unique: true, index: true
      t.string :uri, index: true
      t.string :trained_status, default: 'untrained', index: true
      t.timestamps
    end

    add_index :training_logs, [:root_domain, :trained_status]
  end 

  def down
    drop_table :training_logs
  end
end
