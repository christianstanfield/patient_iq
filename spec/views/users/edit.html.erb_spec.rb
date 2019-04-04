require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  let(:department)    { FactoryBot.create :department }
  let(:administrator) { FactoryBot.create :user, :administrator, department: department }
  let(:employee)      { FactoryBot.create :user, department: department }
  before(:each) do
    @user = assign(:user, record)
    session[:current_user_id] = current_user.id
  end

  context 'when user is an employee' do
    let(:current_user) { employee }

    context 'when record is their own' do
      let(:record) { employee }

      it 'renders the correct attributes' do
        render

        expect(rendered).to match(/#{record.full_name}/)
        expect(rendered).to match(/#{record.role.humanize}/)
        expect(rendered).to match(/#{record.department.name}/)
        salary = number_to_currency(record.salary, precision: 0).gsub('$', '')
        expect(rendered).to match(/\$#{salary}/)
        bonus = number_to_currency(record.bonus, precision: 0).gsub('$', '')
        expect(rendered).to match(/\$#{bonus}/)

        assert_select "form[action=?][method=?]", user_path(@user), "post" do

          assert_select "input[name=?]", "user[phone]"

          assert_select "textarea[name=?]", "user[address]"

          assert_select "input[name=?]", "user[email]"

          assert_select "input[name=?]", "user[password]"

          assert_select "input[name=?]", "user[password_confirmation]"
        end
      end
    end
  end

  context 'when user is an administrator' do
    let(:current_user) { administrator }

    context 'when record is their own' do
      let(:record) { administrator }

      it 'renders the correct attributes' do
        render

        expect(rendered).to match(/#{record.full_name}/)
        expect(rendered).to match(/#{record.role.humanize}/)

        assert_select "form[action=?][method=?]", user_path(@user), "post" do

          assert_select "select[name=?]", "user[department_id]"

          assert_select "input[name=?]", "user[phone]"

          assert_select "textarea[name=?]", "user[address]"

          assert_select "input[name=?]", "user[email]"

          assert_select "input[name=?]", "user[password]"

          assert_select "input[name=?]", "user[password_confirmation]"

          assert_select "input[name=?]", "user[salary]"

          assert_select "input[name=?]", "user[bonus]"
        end
      end
    end

    context 'when record belongs to another user on the same company' do
      let(:record) { employee }

      it 'renders the correct attributes' do
        render

        expect(rendered).to match(/#{record.full_name}/)
        expect(rendered).to match(/#{record.role.humanize}/)

        assert_select "form[action=?][method=?]", user_path(@user), "post" do

          assert_select "select[name=?]", "user[department_id]"

          assert_select "input[name=?]", "user[phone]"

          assert_select "textarea[name=?]", "user[address]"

          assert_select "input[name=?]", "user[email]"

          assert_select "input[name=?]", "user[salary]"

          assert_select "input[name=?]", "user[bonus]"
        end
      end
    end
  end
end
