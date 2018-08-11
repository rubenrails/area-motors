FactoryBot.define do
  factory :enquiry do
    name "John Smith"
    email  "john@smith.com"
    source { Website.amdirect }
  end
end