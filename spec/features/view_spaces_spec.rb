

feature "User can see list of spaces available" do 
    scenario "Shows a list of spaces" do 
        Space.create(name: "10 Downing street", description: "One room flat, suitable for head of state", price: 10, email: "example@test.com")
        visit("/")
        click_link('View spaces')
        expect(page).to have_content('Name: 10 Downing street')
        expect(page).to have_content('Description: One room flat, suitable for head of state')
        expect(page).to have_content('Price: 10')
        expect(page).to have_content('example@test.com')
        expect(page.status_code).to be 200
    end 
end