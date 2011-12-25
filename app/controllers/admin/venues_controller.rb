class Admin::VenuesController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @section_title = 'List'
    @venues = Venue.search_sort_paginate(params)
  end

end
