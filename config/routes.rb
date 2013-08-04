AutoApp::Application.routes.draw do

  root :to => 'makes#index'

  resources :trims
  resources :models
  resources :makes

  get '/get_models'                => "makes#get_models"
  get '/get_trims'                 => "models#get_trims"
  match "model_years"              => "models#model_years"
  match "model_year_trims"         => "trims#get_trims"
  match "trim_info"                => "trims#get_trim_info"
  match "feature_image"            => "trims#feature_image"
  match "autofill_models"          => "makes#autofill_models"
end
