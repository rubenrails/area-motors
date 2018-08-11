FactoryBot.define do
  factory :enquiry do
    name "John Smith"
    email  "john@smith.com"
    source { Website.amdirect }

    after(:build) do |enquiry|
      create(:car_listing, enquiry: enquiry)
    end
  end
end