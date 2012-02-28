class Api::EventsController < Api::ApiController
    def index
    respond_to do |format|
      format.json {
          json_models Event.all
      }
    end
  end
  def show
    respond_to do |format|
      format.json {
        json_model Event.find(params[:id])
      }
    end
  end
  
end
