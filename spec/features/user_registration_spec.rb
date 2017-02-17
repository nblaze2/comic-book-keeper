require 'rails_helper'
require "validates_email_format_of/rspec_matcher"

feature 'user creates an account', %q(

  As a prospective user
  I want to create an account
  So that I can post items and review them

) do

  scenario 'successfully registers an account' do
    visit '/'
    click_on 'Sign up'
    fill_in 'user_name', with: 'Tesla Testerton'
    fill_in 'Email', with: 'test@dummy.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    click_on 'Create Account'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('Edit User Profile')
  end

  scenario 'fails to register an account with blank form' do
    visit '/'
    click_on 'Sign up'
    click_on 'Create Account'

    expect(page).to have_content('errors prohibited this user from being saved:')
    expect(page).to have_content('Sign up')
  end

  scenario 'fails to register an account with invalid email' do
    visit '/'
    click_on 'Sign up'
    fill_in 'Name', with: 'Tesla Testerton'
    fill_in 'Email', with: '..oops@denie.d'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    click_on 'Create Account'
    # should validate_email_format_of(:email).with_message('is not not a valid email address')
    expect(page).to have_content('is not a valid email address')
    expect(page).to have_content('Sign up')
  end
end
