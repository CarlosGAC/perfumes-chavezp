namespace :db do
  
  desc "Dumps the database into db/perfumeschavez.sql"
  task :dump => :environment do
    cmd = nil
    with_config do |user, password, db|
      cmd = "mysqldump -u deploy --password='mysql123' perfumes_production > #{Rails.root}/db/backups/perfumeschavez.sql"
    end
    puts cmd
    exec cmd
  end
  
  desc "Restores the database"
  task :restore => :environment do
    cmd = nil
    cmd = "cd #{Rails.root.join('db', 'backups')}"
    exec cmd
    cmd = nil
    cmd = "mysql -u #{ActiveRecord::Base.connection_config[:username]} -p #{ActiveRecord::Base.connection_config[:password]} #{ActiveRecord::Base.connection_config[:database]} < perfumeschavez.sql"
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    puts cmd
    exec cmd
  end
  
  desc "Imports csv file with the zipcodes"
  task :importcp => :environment do
    postalcodes = []
    CSV.foreach("#{Rails.root}/app/assets/Jalisco.csv", headers: true, skip_blanks: true, encoding: "ISO8859-1:utf-8") do |row|
      rowh = row.to_h
      postalcodes << PostalCode.new(rowh)
    end
    PostalCode.import(postalcodes)
  end
  
  private

  def with_config
    yield ActiveRecord::Base.connection_config[:username],
    ActiveRecord::Base.connection_config[:password],
    ActiveRecord::Base.connection_config[:database]
  end
end