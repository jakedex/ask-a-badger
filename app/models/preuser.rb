class Preuser < ActiveRecord::Base
  validates uniqueness: { case_sensitive: false }
end
