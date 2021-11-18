feature "Logged in user can check booking for their spaces" do 
    scenario "User can find a list of bookings in their my-spaces page" do 
    login_steps
    user2 = Account.create(name: "Johnny", email: "johnnybravo@example.com", password: "test4")
    visit("/")
    click_link('View spaces')
    click_button('Book a night')
    fill_in("date", with: "2025-01-01")
    click_button('Book')
    visit('/login')
    fill_in('email', with: 'Bigmoneybob@hotmail.com')
    fill_in('password', with: 'test')
    click_button('Log in')
    click_link('My spaces')

    expect(page).to have_content('2025-01-01')
    expect(page.status_code).to be 200
    end 
end 