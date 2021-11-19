feature "A user can not booked the same space and time as an approved booking" do 
  scenario "User tries to book an approved booking" do
      user = Account.create(name: "Lessermoneymike", email: "Lessermoneymike@hotmail.com", password: "test2")
      user_id = Account.get_id(email: user.email)
      space = Space.create(name: "10 downing street", description: "One room flat, suitable for head of state", price: 10, email: "example@test.com", account_id: user_id)
      space_id = Space.get_id(email: 'example@test.com', name: '10 downing street')
      Booking.create(date: '2025-01-01', approval_status: 'Approved', account_id: user_id, space_id: space_id)
      Account.create(name: "Bigmoneybob", email: "Bigmoneybob@hotmail.com", password: "test3")
      visit("/")
      click_link('Log in')
      fill_in('email', with: 'Bigmoneybob@hotmail.com')
      fill_in('password', with: 'test3')
      click_button('Log in')
      click_button('Book a night')
      fill_in "date", with: "2025-01-01"
      click_button('Book')
      expect(page).to have_content('Booking failed, this date has already been booked.')
  end 
end