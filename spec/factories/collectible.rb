FactoryGirl.define do
  factory :collectible do
    media 'Comic'
    name_of_item 'Uncanny X-Men'
    year '1981'
    sequence(:issue_num) { |n| "#{141 + n}" }
    writer 'Chris Claremont'
    publisher 'Marvel'
    notes "The first issue of new title 'Uncanny X-Men'"
  end
end
