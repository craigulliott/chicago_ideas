class Admin::DaysController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @section_title = 'List'
    @days = Day.search_sort_paginate(params)
  end

end
