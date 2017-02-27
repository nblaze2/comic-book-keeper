require 'rails_helper'

xfeature 'authenticated user sorts a list of comics', %q(

  As an authenticated user
  I want to sort a list of collectibles
  So that I can quickly organize collectibles

) do

  scenario 'user can sort by...' do
    # multiple sort tests?
  end
end

xfeature 'authenticated user searches list for specific comic', %q(

  As an authenticated user
  I want to search the database for certain collectibles
  So that I can quickly find the collectibles I want

) do

  scenario 'user can search db by story title' do
    # multiple sort tests?
  end

  scenario 'user can search db by partial name' do
    # multiple sort tests?
  end

  scenario 'user can search db by issue number' do
    # multiple sort tests?
  end

  scenario 'user can search db by artist' do
    # multiple sort tests?
  end

  scenario 'user can search db by writer' do
    # multiple sort tests?
  end
end

xfeature 'authenticated user selects specific comics from a list', %q(

  As an authenticated user
  I want to be able to select certain collectibles
  So that I can compare them

) do

  scenario 'user picks several comics from a list to compare them' do
    #
  end
end
