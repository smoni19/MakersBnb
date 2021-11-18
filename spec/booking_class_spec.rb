require 'booking'

describe Booking do
  describe '.create' do
    it 'creates a new booking' do
      booking = Booking.create(date: "2025-01-01", approval_status: "pending", account_id: 1, space_id: 1)
			expect(booking.date).to eq "2025-01-01"
    end
  end
end