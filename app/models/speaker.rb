class Speaker < ActiveRecord::Base
  belongs_to :year
  belongs_to :user
end
