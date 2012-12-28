class ModelYear < ActiveRecord::Base
  attr_accessible :model_id, :year, :edmunds_id
  belongs_to :model
end
