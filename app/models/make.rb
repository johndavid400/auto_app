class Make < ActiveRecord::Base
  attr_accessible :name, :edmunds_id

  has_many :models

  def newest_model_year
    models.collect{|s| s.model_years.map{|s| s.year }.max }.max
  rescue
    "n/a"
  end

end
