require 'pg'

class Account
  attr_reader :name, :email, :password

  def initialize(name:, email:, password:)
    @name = name
    @email = email
    @password = password
  end

  def self.create(name:, email:, password:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec_params('INSERT INTO accounts (name, email, password) VALUES($1, $2, $3) RETURNING id, name, email, password;', [name, email, password])
    Account.new(name: result[0]['name'], email: result[0]['email'], password: result[0]['password'])
  end
end