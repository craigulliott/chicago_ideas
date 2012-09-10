class Api::TalksController < Api::ApiController
  def index
    respond_to do |format|
      format.json {
        if request.path.include? 'speakers'
          @parent = User.find(params[:speaker_id]) 
          @chapters = @parent.performances.collect{|p| p.chapter }.flatten
          @talks = @chapters.collect{|c| c.talk }
          json_models @talks
        elsif request.path.include? 'days'
          @parent = parent_model
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
