class Admin::CategoriesController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @section_title = 'List'
    @categories = Category.search_sort_paginate(params)
  end

end
