require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:department)    { FactoryBot.create :department }
  let(:administrator) { FactoryBot.create :user, :administrator, department: department }
  let(:employee)      { FactoryBot.create :user, department: department }
  let(:alt_employee)  { FactoryBot.create :user }
  let(:valid_session) { { current_user_id: current_user.id } }

  describe "PUT #update" do

    context 'when updating phone' do
      let(:existing_phone) { '0987654321' }
      let(:new_phone)      { '1234567890' }

      context 'when user is an employee' do
        let(:current_user) { employee }

        context 'when record is their own' do
          let(:record) { employee }

          it 'should successfully update record' do
            record.update! phone: existing_phone
            expect(record.phone).to_not eq(new_phone)

            params = { id: record.id, user: { phone: new_phone } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.phone).to eq(new_phone)
          end
        end

        context 'when record belongs to another user on the same company' do
          let(:record) { administrator }

          it 'should not update record' do
            record.update! phone: existing_phone
            expect(record.phone).to_not eq(new_phone)

            params = { id: record.id, user: { phone: new_phone } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.phone).to eq(existing_phone)
          end
        end

        context 'when record belongs to another user from another company' do
          let(:record) { alt_employee }

          it 'should not update record' do
            record.update! phone: existing_phone
            expect(record.phone).to_not eq(new_phone)

            params = { id: record.id, user: { phone: new_phone } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.phone).to eq(existing_phone)
          end
        end
      end

      context 'when user is an administrator' do
        let(:current_user) { administrator }

        context 'when record is their own' do
          let(:record) { administrator }

          it 'should successfully update record' do
            record.update! phone: existing_phone
            expect(record.phone).to_not eq(new_phone)

            params = { id: record.id, user: { phone: new_phone } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.phone).to eq(new_phone)
          end
        end

        context 'when record belongs to another user on the same company' do
          let(:record) { employee }

          it 'should successfully update record' do
            record.update! phone: existing_phone
            expect(record.phone).to_not eq(new_phone)

            params = { id: record.id, user: { phone: new_phone } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.phone).to eq(new_phone)
          end
        end

        context 'when record belongs to another user from another company' do
          let(:record) { alt_employee }

          it 'should not update record' do
            record.update! phone: existing_phone
            expect(record.phone).to_not eq(new_phone)

            params = { id: record.id, user: { phone: new_phone } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.phone).to eq(existing_phone)
          end
        end
      end
    end

    context 'when updating address' do
      let(:existing_address) { '123 real st' }
      let(:new_address)      { '321 fake st' }

      context 'when user is an employee' do
        let(:current_user) { employee }

        context 'when record is their own' do
          let(:record) { employee }

          it 'should successfully update record' do
            record.update! address: existing_address
            expect(record.address).to_not eq(new_address)

            params = { id: record.id, user: { address: new_address } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.address).to eq(new_address)
          end
        end

        context 'when record belongs to another user on the same company' do
          let(:record) { administrator }

          it 'should not update record' do
            record.update! address: existing_address
            expect(record.address).to_not eq(new_address)

            params = { id: record.id, user: { address: new_address } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.address).to eq(existing_address)
          end
        end

        context 'when record belongs to another user from another company' do
          let(:record) { alt_employee }

          it 'should not update record' do
            record.update! address: existing_address
            expect(record.address).to_not eq(new_address)

            params = { id: record.id, user: { address: new_address } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.address).to eq(existing_address)
          end
        end
      end

      context 'when user is an administrator' do
        let(:current_user) { administrator }

        context 'when record is their own' do
          let(:record) { administrator }

          it 'should successfully update record' do
            record.update! address: existing_address
            expect(record.address).to_not eq(new_address)

            params = { id: record.id, user: { address: new_address } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.address).to eq(new_address)
          end
        end

        context 'when record belongs to another user on the same company' do
          let(:record) { employee }

          it 'should successfully update record' do
            record.update! address: existing_address
            expect(record.address).to_not eq(new_address)

            params = { id: record.id, user: { address: new_address } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.address).to eq(new_address)
          end
        end

        context 'when record belongs to another user from another company' do
          let(:record) { alt_employee }

          it 'should not update record' do
            record.update! address: existing_address
            expect(record.address).to_not eq(new_address)

            params = { id: record.id, user: { address: new_address } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.address).to eq(existing_address)
          end
        end
      end
    end

    context 'when updating email' do
      let(:existing_email) { 'yojimbo@kurosawa.com' }
      let(:new_email)      { 'ikiru@kurosawa.com' }

      context 'when user is an employee' do
        let(:current_user) { employee }

        context 'when record is their own' do
          let(:record) { employee }

          it 'should successfully update record' do
            record.update! email: existing_email
            expect(record.email).to_not eq(new_email)

            params = { id: record.id, user: { email: new_email } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.email).to eq(new_email)
          end
        end

        context 'when record belongs to another user on the same company' do
          let(:record) { administrator }

          it 'should not update record' do
            record.update! email: existing_email
            expect(record.email).to_not eq(new_email)

            params = { id: record.id, user: { email: new_email } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.email).to eq(existing_email)
          end
        end

        context 'when record belongs to another user from another company' do
          let(:record) { alt_employee }

          it 'should not update record' do
            record.update! email: existing_email
            expect(record.email).to_not eq(new_email)

            params = { id: record.id, user: { email: new_email } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.email).to eq(existing_email)
          end
        end
      end

      context 'when user is an administrator' do
        let(:current_user) { administrator }

        context 'when record is their own' do
          let(:record) { administrator }

          it 'should successfully update record' do
            record.update! email: existing_email
            expect(record.email).to_not eq(new_email)

            params = { id: record.id, user: { email: new_email } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.email).to eq(new_email)
          end
        end

        context 'when record belongs to another user on the same company' do
          let(:record) { employee }

          it 'should successfully update record' do
            record.update! email: existing_email
            expect(record.email).to_not eq(new_email)

            params = { id: record.id, user: { email: new_email } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.email).to eq(new_email)
          end
        end

        context 'when record belongs to another user from another company' do
          let(:record) { alt_employee }

          it 'should not update record' do
            record.update! email: existing_email
            expect(record.email).to_not eq(new_email)

            params = { id: record.id, user: { email: new_email } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.email).to eq(existing_email)
          end
        end
      end
    end

    context 'when updating salary' do
      let(:existing_salary) { 100_000 }
      let(:new_salary)      { 1_000_000 }

      context 'when user is an employee' do
        let(:current_user) { employee }

        context 'when record is their own' do
          let(:record) { employee }

          it 'should not update record' do
            record.update! salary: existing_salary
            expect(record.salary).to_not eq(new_salary)

            params = { id: record.id, user: { salary: new_salary } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.salary).to eq(existing_salary)
          end
        end

        context 'when record belongs to another user on the same company' do
          let(:record) { administrator }

          it 'should not update record' do
            record.update! salary: existing_salary
            expect(record.salary).to_not eq(new_salary)

            params = { id: record.id, user: { salary: new_salary } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.salary).to eq(existing_salary)
          end
        end

        context 'when record belongs to another user from another company' do
          let(:record) { alt_employee }

          it 'should not update record' do
            record.update! salary: existing_salary
            expect(record.salary).to_not eq(new_salary)

            params = { id: record.id, user: { salary: new_salary } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.salary).to eq(existing_salary)
          end
        end
      end

      context 'when user is an administrator' do
        let(:current_user) { administrator }

        context 'when record is their own' do
          let(:record) { administrator }

          it 'should successfully update record' do
            record.update! salary: existing_salary
            expect(record.salary).to_not eq(new_salary)

            params = { id: record.id, user: { salary: new_salary } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.salary).to eq(new_salary)
          end
        end

        context 'when record belongs to another user on the same company' do
          let(:record) { employee }

          it 'should successfully update record' do
            record.update! salary: existing_salary
            expect(record.salary).to_not eq(new_salary)

            params = { id: record.id, user: { salary: new_salary } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.salary).to eq(new_salary)
          end
        end

        context 'when record belongs to another user from another company' do
          let(:record) { alt_employee }

          it 'should not update record' do
            record.update! salary: existing_salary
            expect(record.salary).to_not eq(new_salary)

            params = { id: record.id, user: { salary: new_salary } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.salary).to eq(existing_salary)
          end
        end
      end
    end

    context 'when updating bonus' do
      let(:existing_bonus) { 10_000 }
      let(:new_bonus)      { 100_000 }

      context 'when user is an employee' do
        let(:current_user) { employee }

        context 'when record is their own' do
          let(:record) { employee }

          it 'should not update record' do
            record.update! bonus: existing_bonus
            expect(record.bonus).to_not eq(new_bonus)

            params = { id: record.id, user: { bonus: new_bonus } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.bonus).to eq(existing_bonus)
          end
        end

        context 'when record belongs to another user on the same company' do
          let(:record) { administrator }

          it 'should not update record' do
            record.update! bonus: existing_bonus
            expect(record.bonus).to_not eq(new_bonus)

            params = { id: record.id, user: { bonus: new_bonus } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.bonus).to eq(existing_bonus)
          end
        end

        context 'when record belongs to another user from another company' do
          let(:record) { alt_employee }

          it 'should not update record' do
            record.update! bonus: existing_bonus
            expect(record.bonus).to_not eq(new_bonus)

            params = { id: record.id, user: { bonus: new_bonus } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.bonus).to eq(existing_bonus)
          end
        end
      end

      context 'when user is an administrator' do
        let(:current_user) { administrator }

        context 'when record is their own' do
          let(:record) { administrator }

          it 'should successfully update record' do
            record.update! bonus: existing_bonus
            expect(record.bonus).to_not eq(new_bonus)

            params = { id: record.id, user: { bonus: new_bonus } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.bonus).to eq(new_bonus)
          end
        end

        context 'when record belongs to another user on the same company' do
          let(:record) { employee }

          it 'should successfully update record' do
            record.update! bonus: existing_bonus
            expect(record.bonus).to_not eq(new_bonus)

            params = { id: record.id, user: { bonus: new_bonus } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.bonus).to eq(new_bonus)
          end
        end

        context 'when record belongs to another user from another company' do
          let(:record) { alt_employee }

          it 'should not update record' do
            record.update! bonus: existing_bonus
            expect(record.bonus).to_not eq(new_bonus)

            params = { id: record.id, user: { bonus: new_bonus } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.bonus).to eq(existing_bonus)
          end
        end
      end
    end

    context 'when updating department' do # when department belongs to another company?
      let(:existing_department_id) { record.department.id }
      let(:new_department_id) do
        FactoryBot.create(:department, company: record.company).id
      end

      context 'when user is an employee' do
        let(:current_user) { employee }

        context 'when record is their own' do
          let(:record) { employee }

          it 'should not update record' do
            record.update! department_id: existing_department_id
            expect(record.department_id).to_not eq(new_department_id)

            params = { id: record.id, user: { department_id: new_department_id } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.department_id).to eq(existing_department_id)
          end
        end

        context 'when record belongs to another user on the same company' do
          let(:record) { administrator }

          it 'should not update record' do
            record.update! department_id: existing_department_id
            expect(record.department_id).to_not eq(new_department_id)

            params = { id: record.id, user: { department_id: new_department_id } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.department_id).to eq(existing_department_id)
          end
        end

        context 'when record belongs to another user from another company' do
          let(:record) { alt_employee }

          it 'should not update record' do
            record.update! department_id: existing_department_id
            expect(record.department_id).to_not eq(new_department_id)

            params = { id: record.id, user: { department_id: new_department_id } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.department_id).to eq(existing_department_id)
          end
        end
      end

      context 'when user is an administrator' do
        let(:current_user) { administrator }

        context 'when record is their own' do
          let(:record) { administrator }

          it 'should successfully update record' do
            record.update! department_id: existing_department_id
            expect(record.department_id).to_not eq(new_department_id)

            params = { id: record.id, user: { department_id: new_department_id } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.department_id).to eq(new_department_id)
          end
        end

        context 'when record belongs to another user on the same company' do
          let(:record) { employee }

          it 'should successfully update record' do
            record.update! department_id: existing_department_id
            expect(record.department_id).to_not eq(new_department_id)

            params = { id: record.id, user: { department_id: new_department_id } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.department_id).to eq(new_department_id)
          end
        end

        context 'when record belongs to another user from another company' do
          let(:record) { alt_employee }

          it 'should not update record' do
            record.update! department_id: existing_department_id
            expect(record.department_id).to_not eq(new_department_id)

            params = { id: record.id, user: { department_id: new_department_id } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.department_id).to eq(existing_department_id)
          end
        end
      end
    end

    context 'when updating password' do
      let!(:existing_encrypted_password) { record.password_digest }

      context 'when password and password_confirmation are the same' do
        let(:new_password)              { '12345678' }
        let(:new_password_confirmation) { '12345678' }

        context 'when user is an employee' do
          let(:current_user) { employee }

          context 'when record is their own' do
            let(:record) { employee }

            it 'should successfully update record' do
              params = {
                id: record.id,
                user: {
                  password: new_password,
                  password_confirmation: new_password_confirmation
                }
              }
              put :update, params: params, session: valid_session
              record.reload
              expect(record.password_digest).to_not eq(existing_encrypted_password)
            end
          end

          context 'when record belongs to another user' do
            let(:record) { administrator }

            it 'should not update record' do
              params = {
                id: record.id,
                user: {
                  password: new_password,
                  password_confirmation: new_password_confirmation
                }
              }
              put :update, params: params, session: valid_session
              record.reload
              expect(record.password_digest).to eq(existing_encrypted_password)
            end
          end
        end

        context 'when user is an administrator' do
          let(:current_user) { administrator }

          context 'when record is their own' do
            let(:record) { administrator }

            it 'should successfully update record' do
              params = {
                id: record.id,
                user: {
                  password: new_password,
                  password_confirmation: new_password_confirmation
                }
              }
              put :update, params: params, session: valid_session
              record.reload
              expect(record.password_digest).to_not eq(existing_encrypted_password)
            end
          end

          context 'when record belongs to another user' do
            let(:record) { employee }

            it 'should not update record' do
              params = {
                id: record.id,
                user: {
                  password: new_password,
                  password_confirmation: new_password_confirmation
                }
              }
              put :update, params: params, session: valid_session
              record.reload
              expect(record.password_digest).to eq(existing_encrypted_password)
            end
          end
        end
      end

      # NOTE: just a sanity-check, should already be tested by rails
      context 'when password and password_confirmation are not the same' do
        let(:new_password)              { '12345678' }
        let(:new_password_confirmation) { '123456789' }
        let(:current_user)              { administrator }
        let(:record)                    { administrator }

        it 'should not update record' do
          params = {
            id: record.id,
            user: {
              password: new_password,
              password_confirmation: new_password_confirmation
            }
          }
          put :update, params: params, session: valid_session
          record.reload
          expect(record.password_digest).to eq(existing_encrypted_password)
        end
      end
    end

    context 'when update is successful' do
      let(:current_user) { administrator }
      let(:record)       { administrator }

      it 'should redirect to the user show page' do
        params = { id: record.id, user: { bonus: 1_000_000 } }
        put :update, params: params, session: valid_session
        record.reload
        expect(record.bonus).to eq(1_000_000)

        expect(response).to redirect_to(record)
      end
    end

    context 'when update is not successful' do
      let(:current_user) { administrator }
      let(:record)       { administrator }

      it 'should re-render the edit page' do
        params = { id: record.id, user: { email: 'boss@boss@com' } }
        put :update, params: params, session: valid_session
        record.reload
        expect(record.email).to_not eq('boss@boss@com')

        expect(response).to render_template :edit
      end
    end
  end

  describe "GET #show" do

    context 'when user is an employee' do
      let(:current_user) { employee }

      context 'when record is their own' do
        let(:record) { employee }

        it 'should render show page' do
          get :show, params: { id: record.id }, session: valid_session
          expect(response).to be_successful
          expect(response).to render_template :show
        end
      end

      context 'when record belongs to another user on the same company' do
        let(:record) { administrator }

        it 'should return a 404' do
          get :show, params: { id: record.id }, session: valid_session
          expect(response).to be_not_found
        end
      end

      context 'when record belongs to another user from another company' do
        let(:record) { alt_employee }

        it 'should return a 404' do
          get :show, params: { id: record.id }, session: valid_session
          expect(response).to be_not_found
        end
      end

      context 'when requested user does not exist' do

        it 'should return a 404' do
          expect(current_user.id).to_not eq(0)
          get :show, params: { id: 0 }, session: valid_session
          expect(response).to be_not_found
        end
      end
    end

    context 'when user is an administrator' do
      let(:current_user) { administrator }

      context 'when record is their own' do
        let(:record) { administrator }

        it 'should render show page' do
          get :show, params: { id: record.id }, session: valid_session
          expect(response).to be_successful
          expect(response).to render_template :show
        end
      end

      context 'when record belongs to another user on the same company' do
        let(:record) { employee }

        it 'should render show page' do
          get :show, params: { id: record.id }, session: valid_session
          expect(response).to be_successful
          expect(response).to render_template :show
        end
      end

      context 'when record belongs to another user from another company' do
        let(:record) { alt_employee }

        it 'should return a 404' do
          get :show, params: { id: record.id }, session: valid_session
          expect(response).to be_not_found
        end
      end

      context 'when requested user does not exist' do

        it 'should return a 404' do
          expect(current_user.id).to_not eq(0)
          get :show, params: { id: 0 }, session: valid_session
          expect(response).to be_not_found
        end
      end
    end
  end

  describe "GET #edit" do

    context 'when user is an employee' do
      let(:current_user) { employee }

      context 'when record is their own' do
        let(:record) { employee }

        it 'should render edit page' do
          get :edit, params: { id: record.id }, session: valid_session
          expect(response).to be_successful
          expect(response).to render_template :edit
        end
      end

      context 'when record belongs to another user on the same company' do
        let(:record) { administrator }

        it 'should return a 404' do
          get :edit, params: { id: record.id }, session: valid_session
          expect(response).to be_not_found
        end
      end

      context 'when record belongs to another user from another company' do
        let(:record) { alt_employee }

        it 'should return a 404' do
          get :edit, params: { id: record.id }, session: valid_session
          expect(response).to be_not_found
        end
      end

      context 'when requested user does not exist' do

        it 'should return a 404' do
          expect(current_user.id).to_not eq(0)
          get :edit, params: { id: 0 }, session: valid_session
          expect(response).to be_not_found
        end
      end
    end

    context 'when user is an administrator' do
      let(:current_user) { administrator }

      context 'when record is their own' do
        let(:record) { administrator }

        it 'should render edit page' do
          get :edit, params: { id: record.id }, session: valid_session
          expect(response).to be_successful
          expect(response).to render_template :edit
        end
      end

      context 'when record belongs to another user on the same company' do
        let(:record) { employee }

        it 'should render edit page' do
          get :edit, params: { id: record.id }, session: valid_session
          expect(response).to be_successful
          expect(response).to render_template :edit
        end
      end

      context 'when record belongs to another user from another company' do
        let(:record) { alt_employee }

        it 'should return a 404' do
          get :edit, params: { id: record.id }, session: valid_session
          expect(response).to be_not_found
        end
      end

      context 'when requested user does not exist' do

        it 'should return a 404' do
          expect(current_user.id).to_not eq(0)
          get :edit, params: { id: 0 }, session: valid_session
          expect(response).to be_not_found
        end
      end
    end
  end
end
