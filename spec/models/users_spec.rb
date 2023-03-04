require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(name: 'John Doe', email: 'testing@email.com', password: 'secret')
  end

  context 'Testing Validations' do
    it 'is valid with valid attributes' do
      @user.save
      expect(@user).to be_valid
    end

    it 'is not valid without a name' do
      @user.name = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it 'is not valid without email' do
      @user.email = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it 'is not valid without password' do
      @user.password = nil
      @user.save
      expect(@user).to_not be_valid
    end
  end

  context 'Testing Associations' do
    it 'has_many groups/categories' do
      assoc = User.reflect_on_association(:groups)
      expect(assoc.macro).to eq :has_many
    end

    it 'has_many expenses/transactions' do
      assoc = User.reflect_on_association(:expenses)
      expect(assoc.macro).to eq :has_many
    end
  end
end
