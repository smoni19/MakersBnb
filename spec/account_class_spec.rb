require 'account'

describe Account do
  describe '.create' do
    it 'creates a new user account' do
      user = Account.create(name: "Bigmoneybob", email: "Bigmoneybob@hotmail.com", password: "test")
			expect(user.name).to eq "Bigmoneybob"
    end
  end

  describe '.login' do
    it 'grabs an account from the db as the active user' do
      Account.create(name: "Bigmoneybob", email: "Bigmoneybob@hotmail.com", password: "test")
      Account.create(name: "Lessermoneymike", email: "Lessermoneymike@hotmail.com", password: "test2")
      user = Account.login(email: "Bigmoneybob@hotmail.com", password: "test")
      expect(user.name).to eq "Bigmoneybob"
    end
  end

  describe '.get_id' do
    it 'returns the id of the logged-in user' do
      user = Account.create(name: "Bigmoneybob", email: "Bigmoneybob@hotmail.com", password: "test")
      user_id = Account.get_id(email: user.email)
      expect(user_id).to be_a(String)
    end
  end
end
    