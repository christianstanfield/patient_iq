require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#save' do
    let(:user) { FactoryBot.build :user }

    [:first_name, :last_name, :phone, :address, :email, :salary, :bonus, :role].each do |required_attribute|

      context "when #{required_attribute} is not present" do
        before(:each) do
          user.send "#{required_attribute}=", nil
          expect(user.send required_attribute).to be_nil
        end

        it 'should not save' do
          user.save
          expect(user).to_not be_valid
        end

        it 'should generate the correct error message' do
          user.save
          error_messages = user.errors.full_messages
          expect(error_messages.length > 0).to eq(true)
          expect(error_messages).to include("#{required_attribute.to_s.humanize} can't be blank")
        end
      end

      context "when #{required_attribute} is present" do
        before(:each) do
          expect(user.send required_attribute).to be_present
        end

        it 'should save successfully' do
          user.save
          expect(user).to be_valid
        end
      end
    end

    context 'when phone number has the incorrect number of digits' do
      let(:phone1) { '123' }
      let(:phone2) { '123-456-78901' }

      it 'should not save' do
        user.phone = phone1
        user.save
        expect(user).to_not be_valid

        user.phone = phone2
        user.save
        expect(user).to_not be_valid
      end

      it 'should generate the correct error message' do
        user.phone = phone1
        user.save
        error_messages = user.errors.full_messages
        expect(error_messages.length).to eq(1)
        expect(error_messages.first).to eq('Phone is the wrong length (should be 10 characters)')
      end
    end

    context 'when phone number has the correct number of digits' do
      let(:phone1) { '1234567890' }
      let(:phone2) { '(123) 456-7890' }

      it 'should save successfully' do
        user.phone = phone1
        user.save
        expect(user).to be_valid

        user.phone = phone2
        user.save
        expect(user).to be_valid
      end
    end

    context 'when email is an incorrect format' do
      let(:email1) { 'sjobs@apple@com' }
      let(:email2) { 'sjobs.apple.com' }

      it 'should not save' do
        user.email = email1
        user.save
        expect(user).to_not be_valid

        user.email = email2
        user.save
        expect(user).to_not be_valid
      end

      it 'should generate the correct error message' do
        user.email = email1
        user.save
        error_messages = user.errors.full_messages
        expect(error_messages.length).to eq(1)
        expect(error_messages.first).to eq('Email is invalid')
      end
    end

    context 'when email is the correct format' do
      let(:email) { 'sjobs@apple.com' }

      it 'should save successfully' do
        user.email = email
        user.save
        expect(user).to be_valid
      end
    end

    context 'when password is less then the minimum length' do
      let(:password) { '123' }

      it 'should not save' do
        user.password = password
        user.save
        expect(user).to_not be_valid
      end

      it 'should generate the correct error message' do
        user.password = password
        user.save
        error_messages = user.errors.full_messages
        expect(error_messages.length).to eq(1)
        expect(error_messages.first).to eq('Password is too short (minimum is 8 characters)')
      end
    end
  end
end
