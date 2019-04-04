require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let(:employee)      { FactoryBot.create :user }
  let(:administrator) { FactoryBot.create :user, :administrator }
  let(:valid_session) { { current_user_id: current_user.id } }
  let(:alt_company)   { FactoryBot.create :company }

  describe "PUT #update" do

    context 'when updating name' do
      let(:existing_name) { 'Apple' }
      let(:new_name)      { 'Apple II' }

      context 'when user is an employee' do
        let(:current_user) { employee }

        context 'when company is their own' do
          let(:record) { employee.company }

          it 'should not update record' do
            record.update! name: existing_name
            expect(record.name).to_not eq(new_name)

            params = { id: record.id, company: { name: new_name } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.name).to eq(existing_name)
          end
        end

        context 'when user does not belong to company' do
          let(:record) { alt_company }

          it 'should not update record' do
            record.update! name: existing_name
            expect(record.name).to_not eq(new_name)

            params = { id: record.id, company: { name: new_name } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.name).to eq(existing_name)
          end
        end
      end

      context 'when user is an administrator' do
        let(:current_user) { administrator }

        context 'when company is their own' do
          let(:record) { administrator.company }

          it 'should successfully update record' do
            record.update! name: existing_name
            expect(record.name).to_not eq(new_name)

            params = { id: record.id, company: { name: new_name } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.name).to eq(new_name)
          end
        end

        context 'when user does not belong to company' do
          let(:record) { alt_company }

          it 'should not update record' do
            record.update! name: existing_name
            expect(record.name).to_not eq(new_name)

            params = { id: record.id, company: { name: new_name } }
            put :update, params: params, session: valid_session
            record.reload
            expect(record.name).to eq(existing_name)
          end
        end
      end
    end

    context 'when update is successful' do
      let(:current_user) { administrator }
      let(:record)       { administrator.company }

      it 'should redirect to the company show page' do
        params = { id: record.id, company: { name: 'toolegit' } }
        put :update, params: params, session: valid_session
        record.reload
        expect(record.name).to eq('toolegit')

        expect(response).to redirect_to(record)
      end
    end

    context 'when update is not successful' do
      let(:current_user) { administrator }
      let(:record)       { administrator.company }

      it 'should re-render the edit page' do
        params = { id: record.id, company: { name: '' } }
        put :update, params: params, session: valid_session
        record.reload
        expect(record.name).to_not eq('')

        expect(response).to render_template :edit
      end
    end
  end

  describe "GET #show" do

    context 'when user is an employee' do
      let(:current_user) { employee }

      context 'when company is their own' do
        let(:record) { employee.company }

        it 'should return a 404' do
          get :show, params: { id: record.id }, session: valid_session
          expect(response).to be_not_found
        end
      end

      context 'when user does not belong to company' do
        let(:record) { alt_company }

        it 'should return a 404' do
          get :show, params: { id: record.id }, session: valid_session
          expect(response).to be_not_found
        end
      end

      context 'when requested company does not exist' do

        it 'should return a 404' do
          expect(Company.count).to eq(0)
          get :show, params: { id: 0 }, session: valid_session
          expect(response).to be_not_found
        end
      end
    end

    context 'when user is an administrator' do
      let(:current_user) { administrator }

      context 'when company is their own' do
        let(:record) { administrator.company }

        it 'should render show page' do
          get :show, params: { id: record.id }, session: valid_session
          expect(response).to be_successful
          expect(response).to render_template :show
        end
      end

      context 'when user does not belong to company' do
        let(:record) { alt_company }

        it 'should return a 404' do
          get :show, params: { id: record.id }, session: valid_session
          expect(response).to be_not_found
        end
      end

      context 'when requested company does not exist' do

        it 'should return a 404' do
          expect(Company.count).to eq(0)
          get :show, params: { id: 0 }, session: valid_session
          expect(response).to be_not_found
        end
      end
    end
  end

  describe "GET #edit" do

    context 'when user is an employee' do
      let(:current_user) { employee }

      context 'when company is their own' do
        let(:record) { employee.company }

        it 'should return a 404' do
          get :edit, params: { id: record.id }, session: valid_session
          expect(response).to be_not_found
        end
      end

      context 'when user does not belong to company' do
        let(:record) { alt_company }

        it 'should return a 404' do
          get :edit, params: { id: record.id }, session: valid_session
          expect(response).to be_not_found
        end
      end

      context 'when requested company does not exist' do

        it 'should return a 404' do
          expect(Company.count).to eq(0)
          get :edit, params: { id: 0 }, session: valid_session
          expect(response).to be_not_found
        end
      end
    end

    context 'when user is an administrator' do
      let(:current_user) { administrator }

      context 'when company is their own' do
        let(:record) { administrator.company }

        it 'should render edit page' do
          get :edit, params: { id: record.id }, session: valid_session
          expect(response).to be_successful
          expect(response).to render_template :edit
        end
      end

      context 'when user does not belong to company' do
        let(:record) { alt_company }

        it 'should return a 404' do
          get :edit, params: { id: record.id }, session: valid_session
          expect(response).to be_not_found
        end
      end

      context 'when requested company does not exist' do

        it 'should return a 404' do
          expect(Company.count).to eq(0)
          get :edit, params: { id: 0 }, session: valid_session
          expect(response).to be_not_found
        end
      end
    end
  end
end
