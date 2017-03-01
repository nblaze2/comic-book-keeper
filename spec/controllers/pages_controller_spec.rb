require 'rails_helper'

feature 'site visitor can access FAQ page' do
  scenario 'FAQ page exists' do
    visit '/'
    click_on 'FAQ'
    expect(page).to have_content('FAQ')
    expect(page).to have_content('Comic Book Keeper')
  end
end
