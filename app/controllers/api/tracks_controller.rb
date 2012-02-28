class Api::TracksController < Api::ApiController
    def index
    respond_to do |format|
      format.json {
          json_models Track.all
      }
    end
  end
  def show
    respond_to do |format|
      format.json {
        json_model Track.find(params[:id])
      }
    end
  end
end
