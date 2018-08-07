class Enquiry < ApplicationRecord
  belongs_to :source, class_name: 'Website'
end
