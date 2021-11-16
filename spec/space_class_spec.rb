require 'space'

describe Space do
  subject { described_class.new }
  describe "#create" do
    it "Create a new instance of the Space class" do
      space = Space.create(name: "10 downing street", description: "One room flat, suitable for head of state", price: 10, email: "example@test.com")
      expect(space.name).to eq "10 downing street"
    end
  end

  # describe "#all" do
  #   Space.create(name: "10 downing street", description: "One room flat, suitable for head of state", price: 10, email: "example@test.com")
  #   space = Space.all
  #   expect(space[0].name)
  # end

end