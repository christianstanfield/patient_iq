require 'rails_helper'

RSpec.describe "users/show", type: :view do
  let(:user) { FactoryBot.create :user }
  before(:each) do
    @user = assign(:user, user)
  end

  it 'renders the correct attributes' do
    render
    expect(rendered).to match(/#{user.full_name}/)
    expect(rendered).to match(/#{user.role.humanize}/)
    expect(rendered).to match(/#{user.department.name}/)
    expect(rendered).to match(/#{user.email}/)
    expect(rendered).to match(/#{number_to_phone user.phone}/)
    expect(rendered).to match(/#{user.address}/)
    salary = number_to_currency(user.salary, precision: 0).gsub('$', '')
    expect(rendered).to match(/\$#{salary}/)
    bonus = number_to_currency(user.bonus, precision: 0).gsub('$', '')
    expect(rendered).to match(/\$#{bonus}/)
  end
end
