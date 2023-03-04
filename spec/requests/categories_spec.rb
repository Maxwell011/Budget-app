require 'rails_helper'

RSpec.describe 'Groups', type: :request do
  include Devise::Test::IntegrationHelpers
  before :each do
    @user = User.create(name: 'John Doe', email: 'test@email.com', password: '123456')
    @group1 = Group.create(author_id: @user_id, name: 'Entertainment')
    @group2 = Group.create(author_id: @user_id, name: 'Appliances')

    sign_in @user
    get groups_path
  end

  it 'is a success' do
    expect(response).to have_http_status(:ok)
  end

  it "renders 'index' template" do
    expect(response).to render_template('index')
  end
end
