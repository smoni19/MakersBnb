require 'pg'

class Account
  attr_reader :name, :email

  def initialize(name:, email:)
    @name = name
    @email = email
  end

  def self.create(name:, email:, password:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec_params('INSERT INTO accounts (name, email, password) VALUES($1, $2, $3) RETURNING id, name, email;', [name, email, password])
    Account.new(name: result[0]['name'], email: result[0]['email'])
  end

  def self.login(email:, password:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec_params('SELECT name, email FROM accounts WHERE email = $1 AND password = $2;' , [email, password])
    Account.new(name: result[0]['name'], email: result[0]['email'])
  end
end