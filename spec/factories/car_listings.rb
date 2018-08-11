FactoryBot.define do
  factory :car_listing do
    make 'Ford'
    model 'Focus'
    colour 'White'
    year 2008
    reference 'REF-001'
    url '/ref_001.html'
  end
end