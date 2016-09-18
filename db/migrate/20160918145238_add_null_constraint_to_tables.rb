class AddNullConstraintToTables < ActiveRecord::Migration[5.0]
  def self.up
    change_column_null :news_articles, :root_domain, false
    change_column_null :news_articles, :uri, false
    change_column_null :training_logs, :root_domain, false
    change_column_null :training_logs, :uri, false
    change_column_null :training_logs, :trained_status, false
  end

  def self.down
    change_column_null :news_articles, :root_domain, true
    change_column_null :news_articles, :uri, true
    change_column_null :training_logs, :root_domain, true
    change_column_null :training_logs, :uri, true
    change_column_null :training_logs, :trained_status, true
  end
end
