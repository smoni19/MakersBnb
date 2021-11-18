require 'pg'


class Booking

  attr_reader :date, :space_id, :approval_status, :account_id

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

  def self.get_space_booking(space_id:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec_params('SELECT * FROM bookings WHERE space_id = $1 AND approval_status = $2;', [space_id, 'pending'])
    result.map do |booking|
      Booking.new(date: booking['date'], approval_status: booking['approval_status'], account_id: booking['account_id'], space_id: booking['space_id'])
    end
  end 
end
