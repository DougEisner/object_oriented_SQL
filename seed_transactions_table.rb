require 'pg'
require 'csv'


conn = PG.connect(dbname: 'real_estate')

#conn.exec('DROP TABLE transactions');

conn.exec('SET client_min_messages TO WARNING');

conn.exec('CREATE TABLE IF NOT EXISTS transactions (id serial primary key, street varchar(200), city varchar(30), beds integer, baths integer, sq_ft integer, price integer)')

rows = CSV.readlines('real_estate_data/Sacramentorealestatetransactions.csv', headers: true)

def load_data(rows, conn)
  rows.each do |row|
    street = row['street']
    city = row['city']
    beds = row['beds'].to_i
    baths = row['baths'].to_i
    sq_ft = row['sq__ft'].to_i
    price = row['price'].to_i

    conn.exec("INSERT INTO transactions (street, city, beds, baths, sq_ft, price) VALUES ('#{street}', '#{city}', '#{beds}', '#{baths}', '#{sq_ft}', '#{price}') ")

    # transaction = Transaction.new(street, city)
    # transaction.save
  end
end

load_data(rows, conn)

conn.close

# class Transaction
#   def initialize(street, city)
#     @street = street
#     @city = city
#   end
#
#   def save
#
#   end
# end
