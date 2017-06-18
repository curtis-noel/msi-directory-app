[Rails.env, 'regions', 'states', 'notices', 'groupings', 'institutions'].each do |seed|
  seed_file = "#{Rails.root}/db/seeds/#{seed}.rb"
  if File.exists?(seed_file)
    puts "Loading data: #{seed}"
    require seed_file
  end
end
