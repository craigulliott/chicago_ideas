class Api::YearsController < Api::ApiController
  def index
    respond_to do |format|
      format.json {
          json_models Year.all
      }
    end
  end
  def show
    respond_to do |format|
      format.json {
        json_model Year.find(params[:id])
      }
    end
  end
end
