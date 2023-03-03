require 'rails_helper'

RSpec.describe Expense, type: :model do
  before :each do
    @user = User.create(name: 'John Doe', email: 'test@email.com', password: 'secret')
    @transaction = Expense.new(author: @user, name: 'Brandy', amount: 12.99)
  end

  context 'Testing Validations' do
    it 'is valid with valid attributes' do
      expect(@transaction).to be_valid
    end

    it 'is not valid without a name' do
      @transaction.name = nil
      expect(@transaction).to_not be_valid
    end

    it 'is not valid without an icon' do
      @transaction.amount = nil
      expect(@transaction).to_not be_valid
    end

    it 'has amount, which is numeric data type' do
      expect(@transaction.amount).to be_kind_of Numeric
    end
  end

  context 'Testing Associations' do
    it 'belongs_to User' do
      assoc = Expense.reflect_on_association(:author)
      expect(assoc.macro).to eq :belongs_to
    end

    it 'has_many group_expenses' do
      assoc = Expense.reflect_on_association(:group_expenses)
      expect(assoc.macro).to eq :has_many
    end
  end
end
