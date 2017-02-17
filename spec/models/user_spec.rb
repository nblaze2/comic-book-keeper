require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User.new" do
    it "user is a User object" do
      user = FactoryGirl.create(:user)
      expect(user).to be_a(User) 
    end
  end
end
