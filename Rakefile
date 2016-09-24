require 'rake/testtask'
require 'active_record'
require 'yaml'
require 'json'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = 'test/**/*_test.rb'
end

namespace :db do
  env = ENV.fetch('ENV', 'development')
  db_config = YAML::load(File.open('config/database.yml'))[env]
  if File.exist?("config/secrets/#{env}.ejson")
    decrypted_text = `ejson decrypt config/secrets/#{env}.ejson`
    db_config.merge!(JSON.parse(decrypted_text))
  end
  db_config_admin = db_config.merge({'database' => 'postgres', 'schema_search_path' => 'public'})
  ActiveRecord::Base.logger = Logger.new(File.open('logs/db.log', 'a'))

  desc "Create the database"
  task :create do
    ActiveRecord::Base.establish_connection(db_config_admin)
    ActiveRecord::Base.connection.create_database(db_config["database"])
    puts "Database created."
  end

  desc "Migrate the database"
  task :migrate do
    Rake::Task["db:production_check"].invoke if env == 'production'

    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate/")
    Rake::Task["db:schema"].invoke
    puts "Database migrated."
  end

  desc 'Makes sure master is up to date before running production tasks'
  task :production_check do
    return unless env == 'production'

    changed_files = `git status --porcelain`.strip
    branch = `git rev-parse --abbrev-ref HEAD`.strip

    raise "[PRODUCTION] You can only run migrations for production on master" and abort unless branch == 'master'
    raise "[PRODUCTION] Please push your changes to master before running migrations" and abort unless changed_files.empty?
  end

  desc 'Rolls the schema back to the previous version (specify steps w/ STEP=n).'
  task :rollback do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::Migrator.rollback("db/migrate/", step)
  end

  desc "Drop the database"
  task :drop do
    ActiveRecord::Base.establish_connection(db_config_admin)
    ActiveRecord::Base.connection.drop_database(db_config["database"])
    puts "Database deleted."
  end

  desc "Reset the database"
  task :reset => [:drop, :create, :migrate]

  desc 'Create a db/schema.rb file that is portable against any DB supported by AR'
  task :schema do
    ActiveRecord::Base.establish_connection(db_config)
    require 'active_record/schema_dumper'
    filename = "db/schema.rb"
    File.open(filename, "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
  end
end

namespace :g do
  desc "Generate migration"
  task :migration do
    name = ARGV[1] || raise("Specify name: rake g:migration your_migration")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.open(path, 'w') do |file|
      file.write <<-EOF
class #{migration_class} < ActiveRecord::Migration[5.0]
  def self.up
  end
  def self.down
  end
end
      EOF
    end

    puts "Migration #{path} created"
    abort # needed to stop other tasks
  end
end
