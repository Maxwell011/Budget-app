require 'rails_helper'

RSpec.describe Group, type: :model do
  before :each do
    @user = User.create(name: 'John Doe', email: 'test@email.com', password: 'secret')
    @category = Group.new(author: @user, name: 'Foods')
  end

  context 'Testing Validations' do
    it 'is valid with valid attributes' do
      expect(@category).to be_valid
    end

    it 'is not valid without a name' do
      @category.name = nil
      expect(@category).to_not be_valid
    end
  end

  context 'Testing Associations' do
    it 'belongs_to User' do
      assoc = Group.reflect_on_association(:author)
      expect(assoc.macro).to eq :belongs_to
    end

    it 'has_many group_expenses' do
      assoc = Group.reflect_on_association(:group_expenses)
      expect(assoc.macro).to eq :has_many
    end
  end
end
