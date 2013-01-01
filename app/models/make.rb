class Make < ActiveRecord::Base
  attr_accessible :name, :edmunds_id

  validates_uniqueness_of :edmunds_id, :name
  has_many :models

  def newest_model_year
    models.first.name
    models.collect{|s| s.model_years.map{|s| s.year }.max }.max
  rescue
    "1900"
  end

  def get_models
    return EdmundsApi.new.get_models(edmunds_id)
  end

end
