class Model < ActiveRecord::Base
  attr_accessible :name, :edmunds_id

  belongs_to :make
  has_many :trims

  def sample_image
    if trims.first.images.first.present?
      trims.first.images.first.link
    else
      "http://www.infinitecourses.com/admin/Upload/TestPreparation/634203875405820312_NO%20IMAGE.jpg"
    end
  end

end
