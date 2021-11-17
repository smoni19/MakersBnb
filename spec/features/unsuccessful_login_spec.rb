feature 'User tries to log in before signing up' do 
    scenario 'Email sign in is unsuccessful' do 
        Account.create(name: "Superflydev", email: "Superflydev@gmail.com", password: "test3")
        visit('/login')
        fill_in('email', with: 'Bigmoneybob@hotmail.com')
        fill_in('password', with: 'test')
        click_button('Log in')
        expect(page.status_code).to be 200
        expect(page).to have_content('Unsuccessful! Please check email or password :(')
    end 
end 


     