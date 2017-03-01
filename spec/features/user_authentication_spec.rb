require 'rails_helper'

feature 'unauthenticated user signs in', %q(

  As an unauthenticated user
  I want to sign in
  So that I can create collectibles and keep track of them

) do

  scenario 'successfully signs in' do
    user = FactoryGirl.create(:user)

    visit '/'
    click_on 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content('Sign out')
  end

  scenario 'fails to sign in with a blank form' do
    visit '/'
    click_on 'Sign in'
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
    expect(page).to have_content('Sign in')
  end
end

feature 'authenticated user signs out', %q(

  As an authenticated user
  I want to sign out
  So that no one else can create collectibles on my behalf

) do

  scenario 'successfully signs out' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit '/'
    click_on 'Sign out'
    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_content('Sign in')
  end
end

feature 'authenticated user updates information', %q(

  As an authenticated user
  I want to update my information
  So that I can keep my profile up to date

) do

  scenario 'successfully updates email address' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit '/'
    click_on 'Edit User Profile'
    expect(page).to have_content('Edit User Profile')
    fill_in 'Email', with: 'test2@dummy.com'
    fill_in 'Current password', with: 'password123'
    click_on 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
  end

  scenario 'successfully updates password' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit '/'
    click_on 'Edit User Profile'
    fill_in 'Password', with: '456password'
    fill_in 'Password confirmation', with: '456password'
    fill_in 'Current password', with: 'password123'
    click_on 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
  end
end

feature 'authenticated user deletes an account', %q(

  As an authenticated user
  I want to delete my account
  So that my information is no longer retained by the app

) do

  scenario 'successfully deletes an account' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit '/'
    click_on 'Edit User Profile'
    expect(page).to have_content('Unhappy?')
    click_on 'Cancel my account'
    expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
  end
end
