class Api::QuotesController < Api::ApiController
      def index
    respond_to do |format|
      format.json {
          json_models Quote.all
      }
    end
  end
  def show
    respond_to do |format|
      format.json {
        json_model Quote.find(params[:id])
      }
    end
  end

end
