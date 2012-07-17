class CalendarController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index]

  
  def index
    # If it's a year based list, then return all the mega_talks for that year
    
    @start_date = Date.parse('2012-10-08')
    @end_date = Date.parse('2012-10-14')
    @range = @start_date..@end_date
    
    if params[:year_id].present? and params[:month_id].present? and params[:day_id].present?
      @day = Date.parse('%s-%s-%s' % [params[:year_id], params[:month_id], params[:day_id]])
    else
      @day = Date.parse('2012-10-08')
    end
    
    if @range === @day
      @day_name = @day.strftime("%A")
      @month_name = @day.strftime("%B")
      @day_number = @day.strftime("%e")
      @year_number = @day.strftime("%Y")
      
      if @range === @day.tomorrow
        @tomorrow = @day.tomorrow
        @next = '/years/%s/%s/%s/calendar' % [@tomorrow.strftime("%Y"), @tomorrow.strftime("%m"), @tomorrow.strftime("%d")]
      end
      
      if @range === @day.yesterday
        @yesterday = @day.yesterday
        @prev = '/years/%s/%s/%s/calendar' % [@yesterday.strftime("%Y"), @yesterday.strftime("%m"), @yesterday.strftime("%d")]
      end
      
    else
      # need error message - not a valid date for 2012
    end
    
    
    
    
    @talks = Talk.joins([:talk_brand, {:day => :year}]).where("years.id = '#{params[:year_id]}' AND talk_brands.name = 'Talk'").order('name').search_sort_paginate(params)
    @featured = Talk.joins([:talk_brand, {:day => :year}]).where("years.id = '#{params[:year_id]}' AND talk_brands.name = 'Talk'").order('RAND()').limit(10)
    @speakers = Year.find(params[:year_id]).users.speaker.not_deleted.order('RAND()').limit(6)
    
    @page_title = "Calendar"
    @meta_data = {:page_title => "Calendar", :og_image => "http://www.chicagoideas.com/assets/application/logo.jpg", :og_title => "CIW Talks | Chicago Ideas Week", :og_type => "website", :og_desc => "CIW Talks are 90-minute sessions spread throughout the week that feature 3-6 speakers presenting on various themes. Talks take a variety of forms and may incorporate interviews, conversations or performances."}
   
  end
      
end
