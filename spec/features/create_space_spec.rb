feature "User can add a space" do 
  scenario "User submits space information to a form" do 
      visit("/create_space")
      fill_in('name', with: '10 Downing Street')
      fill_in('description', with: '10 Downing Street')
      fill_in('price_per_night', with: '10')
      fill_in('email', with: 'test@example.com')
      click_button('Create space')
  end 
end