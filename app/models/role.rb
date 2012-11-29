class Role < ActiveRecord::Base
  attr_accessible :nome

  has_many :assignments
  has_many :user, :through => :assignments

  validates_uniqueness_of :nome

end
