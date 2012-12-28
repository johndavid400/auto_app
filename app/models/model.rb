class Model < ActiveRecord::Base
  attr_accessible :name, :edmunds_id

  belongs_to :make
  has_one :image
  has_many :trims
  has_many :model_years

  def sample_image
    if image
      image.link
    elsif trims.first.images.first.present?
      trims.first.images.first.link
    else
      "http://www.infinitecourses.com/admin/Upload/TestPreparation/634203875405820312_NO%20IMAGE.jpg"
    end
  rescue
    "http://www.infinitecourses.com/admin/Upload/TestPreparation/634203875405820312_NO%20IMAGE.jpg"
  end

  def featured_image_available?
    trims.select{|s| s.featured_image.present? }.present?
  end

  def featured_image
    trims.select{|s| s.featured_image.present? }.first.featured_image
  end

end
