class Question < ActiveRecord::Base
  belongs_to :preuser
  belongs_to :user
  belongs_to :answer
end
