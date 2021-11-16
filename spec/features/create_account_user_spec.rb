feature 'User can sign into an account' do 
    scenario 'User visits the site and completes the create account form' do 
        visit("/")
        fill_in('name', with: 'Bigmoneybob')
        fill_in('email', with: 'Bigmoneybob@hotmail.com')
        fill_in('password', with: 'test')
        fill_in('password_confirmation', with: 'test')
        click_button('Create account')
        expect(page.status_code).to be 200
    end
end
        