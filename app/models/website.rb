class Website < ApplicationRecord
  has_many :enquiries, foreign_key: "source_id"
end
