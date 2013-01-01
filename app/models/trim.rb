class Trim < ActiveRecord::Base
  attr_accessible :name, :style_id, :submodel_id, :featured_image

  validates_uniqueness_of :style_id, :name

  belongs_to :model
  has_many :images

  def sample_image
    if featured_image.present?
      featured_image
    elsif images.first.present?
      images.first.link
    end
  rescue
    "http://www.infinitecourses.com/admin/Upload/TestPreparation/634203875405820312_NO%20IMAGE.jpg"
  end

end
