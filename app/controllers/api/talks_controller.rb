class Api::TalksController < Api::ApiController
    def index
    respond_to do |format|
      format.json {
          json_models Talk.all
      }
    end
  end
  def show
    respond_to do |format|
      format.json {
        json_model Talk.find(params[:id])
      }
    end
  end
end
