class Admin::UsersController < Admin::AdminController

  # if the password field is empty, allow the password to stay the same
  before_filter :delete_empty_password_params, :only => :update

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @section_title = 'List'

    @users = User.search_sort_paginate(params)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def show
    @section_title = 'Detail'
    @user = User.find(params[:id])
  end


  # the admin area is allowed to update these protected attributes
  def pre_create(user)
    user.admin = params[:user][:admin]
    return user
  end

  def pre_update(user)
    user.admin = params[:user][:admin]
    return user
  end

  # COLLECTION PAGES
  # ---------------------------------------------------------------------------------------------------------

  # a list of users who are also administrators
  def administrators
    @users = User.admin.search_sort_paginate(params)
  end
  

  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this user account
  def notes
    @user = User.find(params[:id])
    @notes = @user.notes.includes(:author).search_sort_paginate(params, :parent => @user)
  end


  
  # MEMBER PAGES (specifically for administrative users)
  # ---------------------------------------------------------------------------------------------------------
  
  # a log of what the user has done in the admin tool, these log entries are stored in mongodb
  def log_entries
    @user = User.find(params[:id])
    @log_entries = LogEntry.where(:user_id => @user.id).page(params[:page] || 1)
  end
  
  private 
  
    #if the password field is empty, allow the password to stay the same
    # called from a before filter
    def delete_empty_password_params
      params[:user].delete :password if params[:user][:password].blank?
      params[:user].delete :password_confirmation if params[:user][:password_confirmation].blank?
    end
    
  
end
