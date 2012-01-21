class SearchController < ApplicationController
  def index
    @query = params[:q]
    @results = ThinkingSphinx.search(@query)
  end
end
