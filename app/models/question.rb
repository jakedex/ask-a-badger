class Question < ActiveRecord::Base
  belongs_to :preuser
  has_one :answer
end
