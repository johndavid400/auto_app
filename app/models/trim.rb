class Trim < ActiveRecord::Base
  attr_accessible :name, :style_id, :submodel_id

  belongs_to :model
  has_many :images

  def sample_image
    if images.first.present?
      images.first.link
    else
      "http://www.infinitecourses.com/admin/Upload/TestPreparation/634203875405820312_NO%20IMAGE.jpg"
    end
  end

end
