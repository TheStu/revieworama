ASIN::Configuration.configure do |config|
  config.secret        = ENV['ASIN_SECRET']
  config.key           = ENV['ASIN_KEY']
  config.associate_tag = 'scrowed-20'
end
