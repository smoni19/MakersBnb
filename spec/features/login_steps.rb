def login_steps
    user = Account.create(name: "Bigmoneybob", email: "Bigmoneybob@hotmail.com", password: "test")
    user_id = Account.get_id(email: user.email)
    space = Space.create(name: "10 downing street", description: "One room flat, suitable for head of state", price: 10, email: "example@test.com", account_id: user_id)
    visit("/")
    click_link('Log in')
    fill_in('email', with: 'Bigmoneybob@hotmail.com')
    fill_in('password', with: 'test')
    click_button('Log in')
end