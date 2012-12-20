class Make < ActiveRecord::Base
  attr_accessible :name, :edmunds_make_id

  has_many :models
end
