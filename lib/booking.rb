require 'pg'

class Booking

  attr_reader :date

  def initialize(date:, approval_status:, account_id:, space_id:)
    @date = date
    @approval_status = approval_status
    @account_id = account_id
    @space_id = space_id
  end

  def self.create(date:, approval_status:, account_id:, space_id:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec_params('INSERT INTO bookings (date, approval_status, account_id, space_id) VALUES($1, $2, $3, $4) RETURNING id, date, approval_status, account_id, space_id;', [date, approval_status, account_id, space_id])
    Booking.new(date: result[0]['date'], approval_status: result[0]['approval_status'], account_id: result[0]['account_id'], space_id: result[0]['space_id'])
  end
  
end