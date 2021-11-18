feature "User can click to book a space" do 
  scenario "User navigates to spaces page and clicks a book button" do
    login_steps

    click_button('Book a night')
    expect(page.status_code).to be 200
  end
end