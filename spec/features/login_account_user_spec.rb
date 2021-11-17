feature 'User can log in to an account' do 
  scenario 'User visits the site and completes the login form' do 
      Account.create(name: "Bigmoneybob", email: "Bigmoneybob@hotmail.com", password: "test")
      Account.create(name: "Lessermoneymike", email: "Lessermoneymike@hotmail.com", password: "test2")
      visit("/")
      click_link('Log in')
      fill_in('email', with: 'Bigmoneybob@hotmail.com')
      fill_in('password', with: 'test')
      click_button('Log in')
      expect(page.status_code).to be 200
      expect(page).to have_content 'Bigmoneybob'
  end
end