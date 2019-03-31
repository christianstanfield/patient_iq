require 'rails_helper'

RSpec.describe Company, type: :model do

  describe '#save' do

    context 'when name is not present' do
      let(:company) { Company.new name: nil }

      it 'should not save' do
        company.save
        expect(company).to_not be_valid
      end

      it 'should generate the correct error message' do
        company.save
        error_messages = company.errors.full_messages
        expect(error_messages.length).to eq(1)
        expect(error_messages.first).to eq("Name can't be blank")
      end
    end

    context 'when name is present' do
      let(:company) { Company.new name: 'not nil' }

      it 'should save successfully' do
        company.save
        expect(company).to be_valid
      end
    end
  end

  describe '#destroy' do
    let(:company) { FactoryBot.create :company }

    context 'when company has departments' do
      before(:each) do
        FactoryBot.create :department, company: company
        FactoryBot.create :department, company: company
      end

      it 'should successfully destroy them and itself' do
        expect(Company.count).to eq(1)
        expect(Department.where(company: company).count).to eq(2)
        company.destroy

        expect(Company.count).to eq(0)
        expect(Department.where(company: company).count).to eq(0)
      end
    end

    context 'when company has users' do
      before(:each) do
        department = FactoryBot.create :department, company: company
        FactoryBot.create :user, department: department
        FactoryBot.create :user, department: department
      end

      it 'should successfully destroy them and itself' do
        expect(Company.count).to eq(1)
        expect(User.joins(:department).where(departments: { company: company }).count).to eq(2)
        company.destroy

        expect(Company.count).to eq(0)
        expect(User.joins(:department).where(departments: { company: company }).count).to eq(0)
      end
    end
  end
end
