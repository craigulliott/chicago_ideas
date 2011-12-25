class Admin::SpeakersController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @section_title = 'List'
    @speakers = Speaker.search_sort_paginate(params)
  end

end
