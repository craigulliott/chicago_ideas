class Api::PressClippingsController < Api::ApiController
    def index
    respond_to do |format|
      format.json {
          json_models SponsorshipLevel.order("sort").all
      }
    end
  end
  def show
    respond_to do |format|
      format.json {
        json_model SponsorshipLevel.find(params[:id])
      }
    end
  end
end
