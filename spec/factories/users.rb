FactoryGirl.define do
  factory :user, class: 'User' do
    name 'Tesla Testerton'
    email 'test@dummy.gov'
    password 'password123'
  end
end
