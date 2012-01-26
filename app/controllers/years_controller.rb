class YearsController < ApplicationController
  
  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:show]
  
  def show
  end
  
end
