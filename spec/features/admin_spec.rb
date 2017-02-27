# ## Administrators
#
# As an admin user
# I want to see a list of users
# So that I can moderate the users
#
# As an admin user
# I want to see a user's details
# So that I can update or investigate a user
#
# As an admin user
# I want to delete a user
# So that I can remove unwanted users
#
# As an admin user
# I want to delete a collectible
# So that I can remove unwanted collectible
#
# ### Acceptance Criteria:
# * I am prompted to make sure before deleting anything

require 'rails_helper'

xfeature 'user with admin role views a list of users', %q(

  As an admin user
  I want to see a list of users
  So that I can moderate the users

) do

  scenario 'admin sees list of users' do
    user = FactoryGirl.create(:user, role: 'admin')
    user1 = FactoryGirl.create(:user, name: 'Red', email: 'red@mydog.com')
    user2 = FactoryGirl.create(:user, name: 'Josephine', email: 'jogi@mydog.com')
    user3 = FactoryGirl.create(:user, name: 'Bowie', email: 'bowie@mydog.com')
    login_as(user, :scope => :user)

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

xfeature 'user with admin role deletes a user', %q(

  As an admin user
  I want to delete a user
  So that I can remove unwanted users

) do

  scenario 'admin deletes a user' do
    user = FactoryGirl.create(:user, role: 'admin')
    user1 = FactoryGirl.create(:user, email: 'red@mydog.com')
    login_as(user, :scope => :user)
    comic = FactoryGirl.create(:comic, user_id: user.id)

    visit '/'
    expect(page).to have_content('Uncanny X-Men')
    click_on 'Admin Tools'
    expect(page).to have_content('ADMIN TOOLS')
    expect(page).to have_content(user1.email)
    click_on 'Delete User'
    expect(page).to_not have_content(user1.email)
    visit '/'
    expect(page).to_not have_content('Uncanny X-Men')
  end
end

xfeature 'user with admin role deletes a collectible', %q(

  As an admin user
  I want to delete a collectible
  So that I can remove unwanted collectible

) do

  scenario 'admin deletes a collectible' do
    user = FactoryGirl.create(:user, role: 'admin')
    user1 = FactoryGirl.create(:user, email: 'red@mydog.com')
    login_as(user, :scope => :user)
    comic = FactoryGirl.create(:comic, user_id: user1.id)

    visit '/'
    click_on 'Admin Tools'
    expect(page).to have_content('ADMIN TOOLS')
    expect(page).to have_content(comic.title)
    click_on 'Delete Movie'
    expect(page).to_not have_content(comic.title)
  end
end
