class Model < ActiveRecord::Base
  attr_accessible :name, :edmunds_id

  belongs_to :make
  has_many :trims

  def sample_image
    if featured_image_available?
      featured_image
    elsif trims.first.images.first.present?
      trims.first.images.first.link
    else
      "http://www.infinitecourses.com/admin/Upload/TestPreparation/634203875405820312_NO%20IMAGE.jpg"
    end
  end

  def featured_image_available?
    trims.select{|s| s.featured_image.present? }.present?
  end

  def featured_image
    trims.select{|s| s.featured_image.present? }.first.featured_image
  end

end
