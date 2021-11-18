require 'booking'
require 'space'
require 'account'

describe Booking do
  describe '.create' do
    it 'creates a new booking' do
      user = Account.create(name: "Bigmoneybob", email: "Bigmoneybob@hotmail.com", password: "test")
      user_id = Account.get_id(email: user.email)
      space = Space.create(name: "10 downing street", description: "One room flat, suitable for head of state", price: 10, email: "example@test.com", account_id: user_id)
      space_id = Space.get_id(email: space.email, name: space.name)
      booking = Booking.create(date: "2025-01-01", approval_status: "pending", account_id: user_id, space_id: space_id)
			expect(booking.date).to eq "2025-01-01"
    end
  end
end