require 'rails_helper'

RSpec.describe "companies/show", type: :view do
  let(:administrator) { FactoryBot.create :user, :administrator }
  let(:company)       { administrator.company }
  before(:each) do
    @company = assign(:company, company)
    session[:current_user_id] = administrator.id
  end

  it 'renders the correct attributes' do
    render
    expect(rendered).to match(/#{company.name}/)
  end
end
