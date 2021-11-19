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

  def self.get_my_booking(account_id:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec_params('SELECT * FROM bookings WHERE account_id = $1;', [account_id])
    result.map do |booking|
      Booking.new(date: booking['date'], approval_status: booking['approval_status'], account_id: booking['account_id'], space_id: booking['space_id'])
    end
  end

  def self.find_approved_bookings(date:, space_id:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec_params('SELECT * FROM bookings WHERE space_id = $1 AND date = $2 AND approval_status = $3;', [space_id, date, "Approved"])
    result.any? ? true : false
  end


  def self.get_id(space_id:, account_id:, date:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec_params('SELECT id FROM bookings WHERE space_id = $1 AND account_id = $2 AND date = $3;', [space_id, account_id, date])
    return unless result.any?
    return result[0]['id']
  end

  def self.edit_status(booking_id:, new_status:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    result = connection.exec_params('UPDATE bookings SET approval_status = $1 WHERE id = $2;', [new_status, booking_id])
  end
end



