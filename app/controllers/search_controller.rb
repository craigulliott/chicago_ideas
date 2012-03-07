class SearchController < ApplicationController
  
  def index
    @query = params[:q]

    respond_to do |format|
      format.html  {
         @results = ThinkingSphinx.search(@query) || [];
      }
      format.json { 
        @results = ThinkingSphinx.search :conditions => {:name => @query, :title => @query}
        @results.collect!{|x| x.serializable_hash.merge!({:classType => x.class.to_s })}
        render :json => @results
      }
    end
  end
  
  
  
  def speakers
    @query = params[:q]
    respond_to do |format|
      format.html  {
         @results = User.search(@query)
      }
      format.json { 
        @results = ThinkingSphinx.search :conditions => {:name => @query, :title => @query}        
        @results.collect!{|x| x.serializable_hash.merge!({:classType => x.class.to_s })}
        render :json => @results
      }
    end
  end
  
  
  
  def videos
    @query = params[:q]
    respond_to do |format|
      format.html  {
         @results = Chapter.search(@query)
      }
      format.json { 
        @results = ThinkingSphinx.search :conditions => {:name => @query, :title => @query}        
        @results.collect!{|x| x.serializable_hash.merge!({:classType => x.class.to_s })}
        render :json => @results
      }
    end
  end
  
end
