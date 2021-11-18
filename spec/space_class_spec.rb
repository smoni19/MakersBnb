require 'space'
require 'account'

describe Space do
  subject { described_class.new }
  let(:user) { double :user, :get_id => 1 }
  
  describe "#create" do
    it "Create a new instance of the Space class" do
      user = Account.create(name: "Bigmoneybob", email: "Bigmoneybob@hotmail.com", password: "test")
      user_id = Account.get_id(email: user.email)
      space = Space.create(name: "10 downing street", description: "One room flat, suitable for head of state", price: 10, email: "example@test.com", account_id: user_id)
      expect(space.name).to eq "10 downing street"
    end
  end

  describe "#all" do
    it "Returns all spaces held in the spaces table" do
      user = Account.create(name: "Bigmoneybob", email: "Bigmoneybob@hotmail.com", password: "test")
      user_id = Account.get_id(email: user.email)
      Space.create(name: "10 downing street", description: "One room flat, suitable for head of state", price: 10, email: "example@test.com", account_id: user_id)
      Space.create(name: "11 downing street", description: "Great views of the Thames", price: 14, email: "test@example.com", account_id: user_id)
      spaces = Space.all
      expect(spaces.length).to eq 2
      expect(spaces[0].name).to eq "10 downing street"
      expect(spaces[1].email).to eq "test@example.com"
    end
  end

  describe "#my_spaces" do
    it "Takes account id and returns all spaces held in the spaces table for a specific logged in account" do
      user = Account.create(name: "Bigmoneybob", email: "Bigmoneybob@hotmail.com", password: "test")
      user_id = Account.get_id(email: user.email)
      Space.create(name: "10 downing street", description: "One room flat, suitable for head of state", price: 10, email: "example@test.com", account_id: user_id)
      my_spaces = Space.my_spaces(account_id: user_id)
      expect(my_spaces.length).to eq 1
      expect(my_spaces[0].name).to eq "10 downing street"
    end
  end

end