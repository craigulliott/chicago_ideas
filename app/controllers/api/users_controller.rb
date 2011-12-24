class Api::UsersController < Api::ApiController

  # member actions
  # ---------------------------------------------------------------------------------------------------------
  def show
    
  end
  
  
  # collection methods
  # ---------------------------------------------------------------------------------------------------------
  # search methods take a parameter called q (q for "query")
  def search
    json_models User.where(:name => api_params[:q])
  end

end
