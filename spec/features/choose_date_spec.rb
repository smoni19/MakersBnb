feature "User can choose a date to book" do 
  scenario "User navigates to booking page and chooses a date" do
    login_steps
    click_button('Book a night')
    fill_in "date", with: "2025-01-01"
    click_button('Book')
    expect(page.status_code).to be 200
  end
end