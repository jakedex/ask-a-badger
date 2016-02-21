class Course < ActiveRecord::Base
  has_many :questions
  before_save { self.title = title.downcase }
end
