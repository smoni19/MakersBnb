
feature "Index page" do
  scenario "User visits the homepage" do
    visit("/")
    expect(page.status_code).to be 200
    expect(page).to have_content("Welcome to MakersBnB")
    expect(page).to have_link(href: '/spaces')
    expect(page).to have_link(href: '/create_space')
  end

end