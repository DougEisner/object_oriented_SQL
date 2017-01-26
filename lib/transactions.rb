require 'pg'
require 'csv'

class Transaction

  def initialize(options)
    @id = nil
    @street = options['street']
    @city   = options['city']
    @beds   = options['beds'].to_i
    @baths  = options['baths'].to_i
    @sq_ft  = options['sq__ft'].to_i
    @price  = options['price'].to_i
  end

  def self.create_table
    conn = PG.connect(dbname: 'real_estate')
    conn.exec('DROP TABLE IF EXISTS transactions')
    conn.exec('CREATE TABLE IF NOT EXISTS transactions (id serial primary key, street varchar(200), city varchar(30), beds integer, baths integer, sq_ft integer, price integer)')

    rows = CSV.readlines('real_estate_data/Sacramentorealestatetransactions.csv', headers: true)

    rows.each do |row|
      transaction = Transaction.new(row)
      transaction.save(conn)
    end
    conn.close
  end

  def save(conn)
    conn.exec("INSERT INTO transactions (street, city, beds, baths, sq_ft, price) VALUES ('#{@street}', '#{@city}', '#{@beds}', '#{@baths}', '#{@sq_ft}', '#{@price}') ")
  end

end



Transaction.create_table

  #   if @id == nil
  #     create a new instance of Transactions
  #     INSERT into transactions
  #   else @id != nil #there's already an item with that id
  #     UPDATE an entry in transactions
  #
  # end
