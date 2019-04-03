require 'rails_helper'

RSpec.describe "companies/edit", type: :view do
  let(:administrator) { FactoryBot.create :user, :administrator }
  let(:company)       { administrator.company }
  before(:each) do
    @company = assign(:company, company)
    session[:current_user_id] = administrator.id
  end

  it 'renders the correct attributes' do
    render

    assert_select "form[action=?][method=?]", company_path(@company), "post" do

      assert_select "input[name=?]", "company[name]"
    end
  end
end
