module MakesHelper

  def get_new_models(make_id)
    @api2 = EdmundsAPI.new
    @new_models = @api2.get_new_models(make_id)
  end

  def model_search(make_id)
    @api2 = EdmundsAPI.new
    @models = @api2.get_models(make_id)
  end

  def new_model_search(make_id)
    @api2 = EdmundsAPI.new
    @models = @api2.new_models(make_id)
  end


end
