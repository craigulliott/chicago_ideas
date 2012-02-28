class Api::PressClippingsController < Api::ApiController
    def index
    respond_to do |format|
      format.json {
          json_models PressClipping.order('created_at').all
      }
    end
  end
  def show
    respond_to do |format|
      format.json {
        json_model PressClipping.find(params[:id])
      }
    end
  end
end
