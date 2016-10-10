namespace :client_manager do
  desc "Creates new superadmin. Usage: client_manager:superadmin NAME=Test EMAIL=test@test.com PASSWORD=password"
  task superadmin: :environment do
    name = ENV['NAME'].to_s
    email = ENV['EMAIL'].to_s
    password = ENV['PASSWORD'].to_s
    if (ClientManager::User.create_superadmin(name, email, password))
      puts "Super admin created successfully"
    end
  end
end

