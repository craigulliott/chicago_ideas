class Api::SearchController < Api::ApiController

    def index
    @query = params[:q]

    respond_to do |format|
      format.json { 
        @results = ThinkingSphinx.search :conditions => {:name => @query, :title => @query}        
        @results.collect!{|x| x.serializable_hash.merge!({:classType => x.class.to_s })}
        render :json => @results
      }
    end
  end
  
end
