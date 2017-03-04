# ## Administrators
#
# As an admin user
# I want to see a user's details
# So that I can update or investigate a user

# ### Acceptance Criteria:
# * I am prompted to make sure before deleting anything

require 'rails_helper'

feature 'user with admin role views a list of users', %q(

  As an admin user
  I want to see a list of users
  So that I can moderate the users

) do

  scenario 'admin sees list of users' do
    admin = FactoryGirl.create(:user)
    user1 = FactoryGirl.create(:user, name: 'Red', email: 'red@mydog.com')
    user2 = FactoryGirl.create(:user, name: 'Josephine', email: 'jogi@mydog.com')
    user3 = FactoryGirl.create(:user, name: 'Bowie', email: 'bowie@mydog.com')
    login_as(admin, :scope => :user)
    admin.update_attribute :admin, true
    visit '/'
    click_on 'Admin Tools'
    expect(page).to have_content('ADMIN TOOLS')
    expect(page).to have_content('Users')
    expect(page).to have_content(user1.email)
    expect(page).to have_content(user2.name)
    expect(page).to have_content(user3.email)
    expect(page).to have_content('Collectibles')
  end
end

feature 'user with admin role deletes a user', %q(

  As an admin user
  I want to delete a user
  So that I can remove unwanted users

) do

  scenario 'admin deletes a user' do
    admin = FactoryGirl.create(:user)
    user1 = FactoryGirl.create(:user, email: 'red@mydog.com')
    login_as(admin, :scope => :user)
    admin.update_attribute :admin, true
    comic = FactoryGirl.create(:collectible, user_id: user1.id)

    visit '/'
    expect(page).to have_content('ADMIN TOOLS')
    expect(page).to have_content(user1.email)
    click_on 'Delete User'
    expect(page).to_not have_content(user1.email)
  end
end

feature 'user with admin role deletes a collectible', %q(

  As an admin user
  I want to delete a collectible
  So that I can remove unwanted collectible

) do

  scenario 'admin deletes a collectible' do
    admin = FactoryGirl.create(:user)
    user1 = FactoryGirl.create(:user, email: 'red@mydog.com')
    login_as(admin, :scope => :user)
    admin.update_attribute :admin, true
    comic = FactoryGirl.create(:collectible, user_id: user1.id)

    visit '/'
    expect(page).to have_content('ADMIN TOOLS')
    click_on 'View Collectibles'
    expect(page).to have_content(comic.name_of_item)
    click_on 'Details'
    click_on 'Delete'
    expect(page).to_not have_content(comic.name_of_item)
  end
end
