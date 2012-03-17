class Api::TalksController < Api::ApiController
    def index
      respond_to do |format|
        format.json {
          @parent = parent_model
          if @parent.class.name == 'Speaker'
            @parent = User.find(params[:speaker_id]) 
            @chapters = @parent.performances.collect{|p| p.chapter }.flatten
            @talks = @chapters.collect{|c| c.talk }
            json_models @talks
          elsif @parent.class.name == 'Day'
            json_models @parent.talks
          else
              json_models Talk.all
          end
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
