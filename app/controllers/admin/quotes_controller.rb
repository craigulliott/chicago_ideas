class Admin::QuotesController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @quotes = Quote.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this quote
  def show
    @section_title = 'Detail'
    @quote = Quote.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this quote
  def notes
    @quote = Quote.find(params[:id])
    @notes = @quote.notes.includes(:author).search_sort_paginate(params, :parent => @quote)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
