configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  if Sinatra::Application.development?
    set :database, {
        adapter: "sqlite3",
        database: "db/db.sqlite3"
    }
else 
    db_url = 'postgres://[postgres://omjbvxofkxenjp:dd1c39d392c4e989299d4434c26bfa924a4b4bd68eb9d67c2eb6a8ab635c7fb9@ec2-52-45-73-150.compute-1.amazonaws.com:5432/dbfoq4eivde9r9
]'
    db = URI.parse(ENV['DATABASE_URL'] || db_url)
    set :database, {
        adapter: "postgresql",
        host: db.host,
        username: db.user,
        password: db.password,
        database: db.path[1..-1],
        encoding: 'utf8'
    }
end

  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end
