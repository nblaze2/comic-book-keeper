require 'rails_helper'
# require 'database_cleaner'


feature 'authenticated user adds a comic', %q(

  As an authenticated user
  I want to add an item
  So that others can review it

) do

  scenario 'successfully creates a comic' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit '/'
    click_on 'Add a Collectible'
    expect(page).to have_content('New Collectible')
    fill_in 'Year', with: '2016'
    select 'Comic', from: 'Media'
    fill_in 'Name of Item', with: 'Doctor Strange'
    fill_in 'Story Title', with: 'The Way of the Weird'
    fill_in 'Volume Number', with: '1'
    fill_in 'Publisher', with: 'Marvel'
    fill_in 'Cover Artist', with: 'Chris Bachalo'
    fill_in 'Artist', with: 'Chris Bachalo'
    fill_in 'Writer', with: 'Jason Aaron'
    select 'NM', from: 'Condition'
    fill_in 'Estimated Value', with: '20'
    fill_in 'Notes', with: 'Graphic Novel collects issues #1-5'
    click_on 'Submit'

    expect(page).to have_content('Collectible was successfully created.')
    # Create pop up window that asks if user wants to add another?
    # expect(page).to have_content('Would you like to add another collectible?')
  end

  scenario 'fails to creates a collectible with blank form' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit '/'
    click_on 'Add a Collectible'
    click_on 'Submit'
    expect(page).to have_content("errors prohibited")
    expect(page).to have_content('New Collectible')
  end

  scenario 'fails to creates a collectible with invalid year' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit '/'
    click_on 'Add a Collectible'
    fill_in 'Year', with: '216'
    select 'Comic', from: 'Media'
    fill_in 'Name of Item', with: 'Doctor Strange'
    click_on 'Submit'

    expect(page).to have_content('Year is the wrong length')
    expect(page).to have_content('New Collectible')
  end

  # scenario 'user is prompted to confirm if entry is a duplicate' do
    # not sure how to do this one...
  # end
end

feature 'authenticated user views list of collectibles', %q(

  As an authenticated user
  I want to view a list of collectibles
  So that I can pick items to review

) do

  scenario 'successfully views a list of collectibles' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    25.times do
      FactoryGirl.create(:collectible, user_id: user.id)
    end
    visit '/'

    expect(page).to have_content('Uncanny X-Men')
    expect(page).to have_content('1981')
    expect(page).to have_content('142')
    expect(page).to have_content('166')
    expect(page).to have_content('Marvel')
    expect(page).to have_content('Chris Claremont')
  end
end

feature 'authenticated user views comic details', %q(

  As an authenticated user
  I want to view the details about an item
  So that I can get more information about it

  ) do

  scenario 'successfully views details of a collectible' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    comic = FactoryGirl.create(:collectible, issue_num: '142', user_id: user.id)

    visit '/'

    click_on 'Details'
    expect(page).to have_content('Uncanny X-Men')
    expect(page).to have_content('1981')
    expect(page).to have_content('142')
    expect(page).to have_content('Notes')
    expect(page).to have_content("The first issue of new title 'Uncanny X-Men'")
  end
end

feature 'authenticated user updates a comics information', %q(

  As an authenticated user
  I want to update an item's information
  So that I can correct errors or provide new information

  ) do

  scenario 'successfully updates details of a comic' do
    user = FactoryGirl.create(:user)
    comic = FactoryGirl.create(:collectible, user_id: user.id)
    login_as(user, :scope => :user)

    visit '/'

    click_on 'Details'
    click_on 'Edit'
    expect(page).to have_content('Update Information')
    fill_in 'Name of Item', with: 'X-Men'
    fill_in 'Issue Number', with: '141'
    fill_in 'Notes', with: 'Last issue of volume one X-Men'
    click_on 'Submit'
    expect(page).to have_content('X-Men')
    expect(page).to_not have_content('Uncanny')
    expect(page).to have_content('141')
  end

  scenario 'fails to update details of a comic with blank fields' do
    user = FactoryGirl.create(:user)
    comic = FactoryGirl.create(:collectible, user_id: user.id)
    login_as(user, :scope => :user)

    visit '/'

    click_on 'Details'
    click_on 'Edit'
    fill_in 'Name of Item', with: ''
    click_on 'Submit'
    expect(page).to have_content('error')
    expect(page).to have_content('Update Information')
  end
end

feature 'authenticated user deletes a comic', %q(

  As an authenticated user
  I want to delete an item
  So that it is no longer in the inventory

  ) do

  scenario 'successfully deletes a comic' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    comic = FactoryGirl.create(:collectible, name_of_item: 'Die Hard 2', year: '1990', user_id: user.id)

    visit '/'

    click_on 'Details'
    expect(page).to have_content('Die Hard 2')
    expect(page).to have_content('1990')
    click_on 'Delete'
    # figure out how to still use prompt in test...
    expect(page).to have_content('Collectible was successfully destroyed.')
    expect(page).to_not have_content('Die Hard 2')
    expect(page).to_not have_content('1990')
  end
end
