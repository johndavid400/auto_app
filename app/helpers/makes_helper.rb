module MakesHelper

  def get_new_models(make_id)
    @foo = EdmundsAPI.new
    @new_models = @foo.get_new_models(make_id)
  end

end
