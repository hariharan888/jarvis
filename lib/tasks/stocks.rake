namespace :stocks do
  desc "Seed stock data from local assets"
  task seed_new_stock: :environment do
    require 'json'

    seed_file = Rails.root.join('app', 'assets', 'stocks_seed.json')
    if File.exist?(seed_file)
      stocks_data = JSON.parse(File.read(seed_file))

      stocks_data.each do |stock_data|
        Stock.create!(
          name: stock_data['name'],
          ticker: stock_data['ticker'],
          exchange: stock_data['exchange']
        )
      end

      puts "Stock data seeded successfully."
    else
      puts "Seed file not found: #{seed_file}"
    end
  end
end
