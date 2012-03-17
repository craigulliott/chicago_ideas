class Api::EventsController < Api::ApiController
  def index
    respond_to do |format|
      format.json {
        @parent = parent_model
        if @parent && @parent.class.name == 'Day'
          json_models @parent.events
        else
          json_models Event.all
        end
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
