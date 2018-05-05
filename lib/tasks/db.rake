namespace :db do
  
  desc "Dumps the database into db/perfumeschavez.sql"
  task :dump => :environment do
    cmd = nil
    with_config do |user, password, db|
      cmd = "/usr/local/mysql/bin/mysqldump -u #{user} --password='#{password}' #{db} > #{Rails.root}/db/backups/perfumeschavez#{Time.now.strftime("%d%m%Y%H%M%S")}.sql"
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
    cmd = "/usr/local/mysql/bin/mysql -u #{ActiveRecord::Base.connection_config[:username]} -p #{ActiveRecord::Base.connection_config[:password]} #{ActiveRecord::Base.connection_config[:database]} < #{ENV['filename']}"
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    puts cmd
    exec cmd
  end
  
  private

  def with_config
    yield ActiveRecord::Base.connection_config[:username],
    ActiveRecord::Base.connection_config[:password],
    ActiveRecord::Base.connection_config[:database]
  end
end