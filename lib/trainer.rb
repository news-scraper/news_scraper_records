require 'news_scraper'
require 'active_record'
require_relative 'models/training_log'

class Trainer
  class << self
    def train(domain: nil, count: 1)
      training_log_params = { trained_status: 'untrained' }
      training_log_params.merge(root_domain: domain) if domain

      connect_to_database

      training_logs = TrainingLog.where(training_log_params).limit(count)
      puts "#{training_logs.count} training logs found."

      training_logs.each do |log|
        cli_train(log)
      end
    end

    private

    def cli_train(log)
      TrainingLog.mark_claimed(log)
      sleep 1

      url_trainer = NewsScraper::Trainer::UrlTrainer.new(log.uri)
      url_trainer.train

      TrainingLog.mark_trained(log)
    end

    # TODO: default to production?
    def connect_to_database
      env = ENV.fetch('ENV', 'development')
      db_config = YAML::load(File.open('config/database.yml'))[env]
      if File.exist?("config/secrets/#{env}.ejson")
        decrypted_text = `ejson decrypt config/secrets/#{env}.ejson`
        db_config.merge!(JSON.parse(decrypted_text))
      end
      ActiveRecord::Base.logger = Logger.new(File.open('logs/db.log', 'a'))
      ActiveRecord::Base.establish_connection(db_config)
    end
  end
end

