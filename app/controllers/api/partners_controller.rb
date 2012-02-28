class Api::PartnersController < Api::ApiController
    def index
    respond_to do |format|
      format.json {
          json_models Partner.all
      }
    end
  end
  def show
    respond_to do |format|
      format.json {
        json_model Partner.find(params[:id])
      }
    end
  end
end
