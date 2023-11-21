require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    context 'define validation specs' do
      it 'should fail when password and confirmation do not match' do
        user = User.new(
          first_name: 'Bob',
          last_name: 'the Builder',
          email: 'example@example.com',
          password: 'monkey fuzz',
          password_confirmation: 'fuzz monkey'
        )

        expect(user).not_to be_valid
      end

      it 'should fail when email is already taken' do
        user = User.new(
          first_name: 'Bob',
          last_name: 'the Builder',
          email: 'example@example.com',
          password: 'monkey fuzz',
          password_confirmation: 'monkey fuzz'
        )

        user.save

        # conflicting email
        new_user = User.new(
          first_name: 'George',
          last_name: 'the Gorger',
          email: 'example@example.com',
          password: 'monkey fuzz',
          password_confirmation: 'monkey fuzz'
        )

        expect {new_user.save.to raise_error(ActiveRecord::RecordNotUnique)}
      end

      it 'should fail when first name, lastname and email is empty' do
        user = User.new(
          first_name: nil,
          last_name: nil,
          email: nil,
          password: 'monkey fuzz',
          password_confirmation: 'monkey fuzz'
        )

        expect(user).not_to be_valid

        # 3 errors
        expect(user.errors.full_messages).to include("First name can't be blank")
        expect(user.errors.full_messages).to include("Last name can't be blank")
        expect(user.errors.full_messages).to include("Email can't be blank")
      end

      it 'should fail when password and confirmation are empty' do
        user = User.new(
          first_name: 'Bob',
          last_name: 'the Builder',
          email: 'example@example.com',
          password: nil,
          password_confirmation: nil
        )

        expect(user).not_to be_valid

        # 2 errors
        expect(user.errors.full_messages).to include("Password can't be blank")
        expect(user.errors.full_messages).to include("Password confirmation can't be blank")
      end
    end

    context 'password minimum length' do
      it 'should fail when password is below minimum' do
        user = User.new(
          first_name: 'Bob',
          last_name: 'the Builder',
          email: 'example@example.com',
          password: 'ab',
          password_confirmation: 'ab'
        )

        expect(user).not_to be_valid

        # 2 errors
        expect(user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
        expect(user.errors.full_messages).to include("Password confirmation is too short (minimum is 3 characters)")
      end
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should pass to authenticate with valid credentials' do

      password = 'avalidpassword'
      email = 'abc@123.com'

      user = User.new(
        first_name: 'Carol',
        last_name: 'the Caroler',
        email: email,
        password: password,
        password_confirmation: password
      )

      user.save

      # Attempt authentication with provided credentials
      authenticated_user = User.authenticate_with_credentials(email, password)
      expect(authenticated_user).not_to be_nil
    end

    it 'should fail to authenticate with valid credentials' do

      password = 'avalidpassword'
      email = 'abc@123.com'

      user = User.new(
        first_name: 'Carol',
        last_name: 'the Caroler',
        email: email,
        password: password,
        password_confirmation: password
      )

      user.save

      # Attempt authentication with provided credentials
      authenticated_user = User.authenticate_with_credentials(email, 'invalidpassword')
      expect(authenticated_user).to be_nil
    end

    it 'should pass to authenticate with spacing in email' do

      password = 'avalidpassword'
      email = 'abc@123.com'
      login_email = '   abc@123.com   '

      user = User.new(
        first_name: 'Carol',
        last_name: 'the Caroler',
        email: email,
        password: password,
        password_confirmation: password
      )

      user.save

      # Attempt authentication with provided credentials
      authenticated_user = User.authenticate_with_credentials(login_email, password)
      expect(authenticated_user).not_to be_nil
    end

    it 'should pass to authenticate with mixed casing in email' do

      password = 'avalidpassword'
      email = 'abc@123.com'
      login_email = 'aBC@123.cOm'

      user = User.new(
        first_name: 'Carol',
        last_name: 'the Caroler',
        email: email,
        password: password,
        password_confirmation: password
      )

      user.save

      # Attempt authentication with provided credentials
      authenticated_user = User.authenticate_with_credentials(login_email, password)
      expect(authenticated_user).not_to be_nil
    end
  end
end
