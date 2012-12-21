class Make < ActiveRecord::Base
  attr_accessible :name, :edmunds_id

  has_many :models
end
