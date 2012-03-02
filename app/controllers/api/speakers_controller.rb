class Api::SpeakersController < Api::ApiController
    def index
    respond_to do |format|
      format.json {
          json_models User.speaker
      }
    end
  end
  def show
    respond_to do |format|
      format.json {
        begin
        json_model User.speaker.find(params[:id])
        rescue
        render :json => {}
        end
      }
    end
  end
end
