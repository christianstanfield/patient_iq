require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class }

  let(:department)    { FactoryBot.create :department }
  let(:administrator) { FactoryBot.create :user, :administrator, department: department }
  let(:employee)      { FactoryBot.create :user, department: department }
  let(:alt_employee)  { FactoryBot.create :user }

  permissions :show?, :update?, :edit? do

    context 'when user is an employee' do
      let(:current_user) { employee }

      context 'when record is their own' do
        let(:record) { employee }

        it 'should allow access' do
          expect(subject).to permit(current_user, record)
        end
      end

      context 'when record belongs to another user on the same company' do
        let(:record) { administrator }

        it 'should deny access' do
          expect(subject).to_not permit(current_user, record)
        end
      end

      context 'when record belongs to another user from another company' do
        let(:record) { alt_employee }

        it 'should deny access' do
          [:show?, :update?, :edit?].each do |action|
            expect { subject.new(current_user, record).send action }.to raise_error(Pundit::NotAuthorizedError)
          end
        end
      end
    end

    context 'when user is an administrator' do
      let(:current_user) { administrator }

      context 'when record is their own' do
        let(:record) { administrator }

        it 'should allow access' do
          expect(subject).to permit(current_user, record)
        end
      end

      context 'when record belongs to another user on the same company' do
        let(:record) { employee }

        it 'should allow access' do
          expect(subject).to permit(current_user, record)
        end
      end

      context 'when record belongs to another user from another company' do
        let(:record) { alt_employee }

        it 'should deny access' do
          [:show?, :update?, :edit?].each do |action|
            expect { subject.new(current_user, record).send action }.to raise_error(Pundit::NotAuthorizedError)
          end
        end
      end
    end
  end
end
