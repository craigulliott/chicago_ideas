class Api::SearchController < Api::ApiController

    def index
    @query = params[:q]

    respond_to do |format|
      format.json { 
        @results = ThinkingSphinx.search(@query) || []
        @results.collect!{|x| x.serializable_hash.merge!({:classType => x.class.to_s })}
        render :json => @results
      }
    end
  end
  
end
