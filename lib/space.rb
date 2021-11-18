require 'pg'

class Space
  attr_reader :name, :description, :price, :email

  def initialize(name:, description:, price:, email:)
    @name = name
    @description = description
    @price = price
    @email = email
  end

  def self.create(name:, description:, price:, email:, account_id:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec_params('INSERT INTO spaces (name, description, price, email, account_id) VALUES($1, $2, $3, $4, $5) RETURNING id, name, description, price, email, account_id;', [name, description, price, email, account_id])
    Space.new(name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], email: result[0]['email'])
  end

  def self.all
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec_params('SELECT * FROM spaces;')
    result.map do |space|
      Space.new(name: space['name'], description: space['description'], price: space['price'], email: space['email'])
    end
  end

  def self.get_id(email:, name:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec_params('SELECT id FROM accounts WHERE email = $1 AND name = $2;', [email, name])
    return unless result.any?
    return result[0]['id']
  end
end