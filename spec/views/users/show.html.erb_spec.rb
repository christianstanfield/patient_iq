require 'rails_helper'

RSpec.describe "users/show", type: :view do
  let(:department)    { FactoryBot.create :department }
  let(:administrator) { FactoryBot.create :user, :administrator, department: department }
  let(:employee)      { FactoryBot.create :user, department: department }
  let(:current_user)  { employee }
  before(:each) do
    @user = assign(:user, employee)
    session[:current_user_id] = current_user.id
  end

  it 'renders the correct attributes' do
    render
    expect(rendered).to match(/#{employee.full_name}/)
    expect(rendered).to match(/#{employee.role.humanize}/)
    expect(rendered).to match(/#{employee.department.name}/)
    expect(rendered).to match(/#{employee.email}/)
    expect(rendered).to match(/#{number_to_phone employee.phone}/)
    expect(rendered).to match(/#{employee.address}/)
    salary = number_to_currency(employee.salary, precision: 0).gsub('$', '')
    expect(rendered).to match(/\$#{salary}/)
    bonus = number_to_currency(employee.bonus, precision: 0).gsub('$', '')
    expect(rendered).to match(/\$#{bonus}/)
  end

  context 'when user is an employee' do
    let(:current_user) { employee }

    it 'should not render the link to company profile' do
      render
      expect(rendered).to_not match(/\/companies\/#{department.company.id}/)
      expect(rendered).to_not match(/Company Profile/)
    end
  end

  context 'when user is an administrator' do
    let(:current_user) { administrator }

    it 'should render the link to company profile' do
      render
      expect(rendered).to match(/\/companies\/#{department.company.id}/)
      expect(rendered).to match(/Company Profile/)
    end
  end
end
