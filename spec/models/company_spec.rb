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

  describe '#top_employees' do
    let(:company)     { FactoryBot.create :company }
    let(:department1) { FactoryBot.create :department, company: company, name: 'dept1' }
    let(:department2) { FactoryBot.create :department, company: company, name: 'dept2' }

    let(:alt_company)    { FactoryBot.create :company }
    let(:alt_department) { FactoryBot.create :department, company: alt_company }
    let(:alt_user)       { FactoryBot.create :user, department: alt_department, salary: 100_000 }

    before(:each) do
      4.times { |i| FactoryBot.create :user, department: department1, salary: 1_000 + i }
      4.times { |i| FactoryBot.create :user, department: department2, salary: 2_000 + i }
      expect(alt_user.company).to_not eq(company)
      expect(User.count).to eq(9)
      expect(User.order(salary: :desc).first).to eq(alt_user)
    end

    it 'should return the top 3 employees by salary per department' do
      top_employees = company.top_employees
      expect(top_employees.length).to eq(6)

      first_dept = top_employees.first(3)
      expect(first_dept.map(&:name).uniq).to eq(['dept1'])
      expect(first_dept.map(&:salary)).to eq([1_003, 1_002, 1_001])
      expect(User.find_by department: department1, salary: 1_000).to be_present

      second_dept = top_employees.last(3)
      expect(second_dept.map(&:name).uniq).to eq(['dept2'])
      expect(second_dept.map(&:salary)).to eq([2_003, 2_002, 2_001])
      expect(User.find_by department: department2, salary: 2_000).to be_present
    end
  end
end
