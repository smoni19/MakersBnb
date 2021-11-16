require 'space'

describe Space do
  subject { described_class.new }
  describe "#create" do
    it "Create a new instance of the Space class" do
      space = Space.create(name: "10 downing street", description: "One room flat, suitable for head of state", price: 10, email: "example@test.com")
      expect(space.name).to eq "10 downing street"
    end
  end

  describe "#all" do
    it "Returns all spaces held in the spaces table" do
      Space.create(name: "10 downing street", description: "One room flat, suitable for head of state", price: 10, email: "example@test.com")
      Space.create(name: "11 downing street", description: "Great views of the Thames", price: 14, email: "test@example.com")
      spaces = Space.all
      expect(spaces.length).to eq 2
      expect(spaces[0].name).to eq "10 downing street"
      expect(spaces[1].email).to eq "test@example.com"
    end
  end

end