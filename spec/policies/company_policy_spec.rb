require 'rails_helper'

RSpec.describe CompanyPolicy, type: :policy do
  subject { described_class }

  let(:employee)      { FactoryBot.create :user }
  let(:administrator) { FactoryBot.create :user, :administrator }
  let(:alt_company)   { FactoryBot.create :company }

  permissions :show?, :update?, :edit? do

    context 'when user is an employee' do
      let(:current_user) { employee }

      context 'when company is their own' do
        let(:record) { employee.company }

        it 'should deny access' do
          expect(subject).to_not permit(current_user, record)
        end
      end

      context 'when user does not belong to company' do
        let(:record) { alt_company }

        it 'should deny access' do
          [:show?, :update?, :edit?].each do |action|
            expect { subject.new(current_user, record).send action }.to raise_error(Pundit::NotAuthorizedError)
          end
        end
      end
    end

    context 'when user is an administrator' do
      let(:current_user) { administrator }

      context 'when company is their own' do
        let(:record) { administrator.company }

        it 'should allow access' do
          expect(subject).to permit(current_user, record)
        end
      end

      context 'when user does not belong to company' do
        let(:record) { alt_company }

        it 'should deny access' do
          [:show?, :update?, :edit?].each do |action|
            expect { subject.new(current_user, record).send action }.to raise_error(Pundit::NotAuthorizedError)
          end
        end
      end
    end
  end
end
