class Admin::TopicsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @topics = Topic.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this topic
  def show
    @section_title = 'Detail'
    @topic = Topic.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this topic
  def notes
    @topic = Topic.find(params[:id])
    @notes = @topic.notes.includes(:author).search_sort_paginate(params, :parent => @topic)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
