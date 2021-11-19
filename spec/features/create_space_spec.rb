feature "User can add a space" do 
  scenario "User submits space information to a form" do
      Account.create(name: "Lessermoneymike", email: "Lessermoneymike@hotmail.com", password: "test2")
      visit("/")
      click_link('Log in')
      fill_in('email', with: 'Lessermoneymike@hotmail.com')
      fill_in('password', with: 'test2')
      click_button('Log in')
      click_link('Create a space')
      fill_in('name', with: '10 Downing Street')
      fill_in('description', with: '10 Downing Street')
      fill_in('price_per_night', with: '10')
      click_button('Create space')
      expect(page).to have_content('Name: 10 Downing Street')
  end 
end