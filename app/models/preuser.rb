class Preuser < ActiveRecord::Base
  has_many :questions
  validates :phone, uniqueness: { case_sensitive: false }
end
