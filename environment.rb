require 'active_record'

Dir.glob('./lib/*').each do |folder|
  Dir.glob(folder +"/*.rb").each do |file|
    require file
  end
end

# tells AR what db file to use
ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'news_scraper_records'
)
