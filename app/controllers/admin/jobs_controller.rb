class Admin::JobsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @jobs = Job.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this job
  def show
    @section_title = 'Detail'
    @job = Job.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this job
  def notes
    @job = Job.find(params[:id])
    @notes = @job.notes.includes(:author).search_sort_paginate(params, :parent => @job)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
