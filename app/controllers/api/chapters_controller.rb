class Api::ChaptersController < Api::ApiController
  def index
    respond_to do |format|
      format.json {
        if @parent && @parent.class.name = 'Talk'
          json_models @parent.chapters
        else
          json_models Chapter.all
        end
      }
    end
  end
  def show
    respond_to do |format|
      format.json {
        json_model Chapter.find(params[:id])
      }
    end
  end
end
