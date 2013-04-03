class AllowedUser < ActiveRecord::Base
  attr_accessible :email, :name
end
