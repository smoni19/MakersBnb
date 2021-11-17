feature "User can add a space" do 
  scenario "User submits space information to a form" do 
      visit("/create_space")
      fill_in('name', with: '10 Downing Street')
      fill_in('description', with: '10 Downing Street')
      fill_in('price_per_night', with: '10')
      click_button('Create space')
      expect(page).to have_content('Name: 10 Downing Street')
  end 
end