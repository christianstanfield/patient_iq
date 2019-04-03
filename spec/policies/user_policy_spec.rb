require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class }

  let(:employee)      { FactoryBot.create :user }
  let(:administrator) { FactoryBot.create :user, :administrator }

  permissions :show?, :update?, :edit? do

    context 'when user is an employee' do
      let(:current_user) { employee }

      context 'when record is their own' do
        let(:record) { employee }

        it 'should allow access' do
          expect(subject).to permit(current_user, record)
        end
      end

      context 'when record belongs to another user' do
        let(:record) { administrator }

        it 'should deny access' do
          expect(subject).to_not permit(current_user, record)
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

      context 'when record belongs to another user' do
        let(:record) { employee }

        it 'should allow access' do
          expect(subject).to permit(current_user, record)
        end
      end
    end
  end
end
