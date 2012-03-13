class JobsController < ApplicationController
  
  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @jobs = Job.published.search_sort_paginate(params)
    @meta_data = {:page_title => "CIW Jobs", :og_image => "", :og_title => "CIW Jobs | Chicago Ideas Week", :og_type => "website", :og_desc => "Job opportunities at Chicago Ideas Week"}
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this job
  def show
    @section_title = 'Detail'
    @job = Job.find(params[:id])
    @meta_data = {:page_title => "CIW Jobs", :og_image => "", :og_title => "CIW Jobs | Chicago Ideas Week", :og_type => "website", :og_desc => "Job opportunities at Chicago Ideas Week"}
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
