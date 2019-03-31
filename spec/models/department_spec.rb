require 'rails_helper'

RSpec.describe Department, type: :model do

  describe '#save' do
    let(:company) { FactoryBot.create :company }

    context 'when name is not present' do
      let(:department) { Department.new company: company, name: nil }

      it 'should not save' do
        department.save
        expect(department).to_not be_valid
      end

      it 'should generate the correct error message' do
        department.save
        error_messages = department.errors.full_messages
        expect(error_messages.length).to eq(1)
        expect(error_messages.first).to eq("Name can't be blank")
      end
    end

    context 'when name is present' do
      let(:department) { Department.new company: company, name: 'not nil' }

      it 'should save successfully' do
        department.save
        expect(department).to be_valid
      end
    end
  end

  describe '#destroy' do
    let(:department) { FactoryBot.create :department }

    context 'when department has users' do
      before(:each) do
        FactoryBot.create :user, department: department
        FactoryBot.create :user, department: department
      end

      it 'should successfully destroy them and itself' do
        expect(Department.count).to eq(1)
        expect(User.where(department: department).count).to eq(2)
        department.destroy

        expect(Department.count).to eq(0)
        expect(User.where(department: department).count).to eq(0)
      end
    end
  end
end
