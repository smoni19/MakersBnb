require 'pg'

class Booking

  def self.create(date:, approval_status:, account_id:, space_id:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
  end
end