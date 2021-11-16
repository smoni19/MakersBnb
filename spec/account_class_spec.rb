require 'account'

describe Account do
  describe '.create' do
    it 'creates a new user account' do
      user = Account.create(name: "Bigmoneybob", email: "Bigmoneybob@hotmail.com", password: "test")
			expect(user.name).to eq "Bigmoneybob"
    end
  end
end
    