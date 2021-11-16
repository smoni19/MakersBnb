require 'pg'

class Space
  attr_reader :name, :description, :price, :email

  def initialize(name:, description:, price:, email:)
    @name = name
    @description = description
    @price = price
    @email = email
  end

  def self.create(name:, description:, price:, email:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec_params('INSERT INTO spaces (name, description, price, email) VALUES($1, $2, $3, $4) RETURNING id, name, description, price, email;', [name, description, price, email])
    Space.new(name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], email: result[0]['email'])
  end

  def self.all
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec_params('SELECT * FROM spaces;')
    result.map do |space|
      Space.new(name: space['name'], description: space['description'], price: space['price'], email: space['email'])
    end
  end
end