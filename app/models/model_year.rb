class ModelYear < ActiveRecord::Base
  attr_accessible :model_id, :year, :edmunds_id
  validates_uniqueness_of :edmunds_id, :year
  belongs_to :model
end
