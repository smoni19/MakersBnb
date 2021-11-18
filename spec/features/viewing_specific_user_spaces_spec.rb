feature "A specific user can see a list of their spaces" do 
    scenario "User clicks on their spaces page" do
        user = Account.create(name: "Bigmoneybob", email: "Bigmoneybob@hotmail.com", password: "test")
        account_id = Account.get_id(email: user.email)
        Space.create(name: "10 Downing street", description: "One room flat, suitable for head of state", price: 10, email: "example@test.com", account_id: account_id)
        visit("/my_spaces")
        expect(page).to have_content('Name: 10 Downing street')
        expect(page).to have_content('Description: One room flat, suitable for head of state')
        expect(page).to have_content('Price: 10')
        expect(page.status_code).to be 200
    end 
end 





