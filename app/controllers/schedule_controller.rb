class ScheduleController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index]

  
  def index
    
    @start_date = Date.parse('2012-10-08')
    @end_date = Date.parse('2012-10-14')
    @range = @start_date..@end_date
    
    if params[:year_id].present? and params[:month_id].present? and params[:day_id].present?
      @day = Date.parse('%s-%s-%s' % [params[:year_id], params[:month_id], params[:day_id]])
    else
      @day = Date.parse('2012-10-08')
    end
    
    type = params[:type]
    
    if(type == 'all_talks')
      talks = Talk.joins([:talk_brand, :day]).where("days.date = '#{@day}'").order('talks.start_time, talks.end_time')
      @schedule = talks
    elsif(type == 'Talk' || type == 'Megatalk' || type == 'Edison Talk')
      talks = Talk.joins([:talk_brand, :day]).where("days.date = '#{@day}' AND talk_brands.name = '#{type}'").order('talks.start_time, talks.end_time')
      @schedule = talks
    elsif(type == 'Lab')
      labs = EventBrand.find_by_name("Lab").events.joins(:day).where("days.date = '#{@day}'").order('start_time, end_time')
      @schedule = labs
    elsif(type == 'Partner Program')
      partner_programs = EventBrand.find_by_name("Partner Program").events.joins(:day).where("days.date = '#{@day}'").order('start_time, end_time')
      @schedule = partner_programs
    else
      talks = Talk.joins([:talk_brand, :day]).where("days.date = '#{@day}'").order('talks.start_time, talks.end_time')
      labs = EventBrand.find_by_name("Lab").events.joins(:day).where("days.date = '#{@day}'").order('start_time, end_time')
      partner_programs = EventBrand.find_by_name("Partner Program").events.joins(:day).where("days.date = '#{@day}'").order('start_time, end_time')
      @schedule = talks + labs + partner_programs
    end
    
    
    
    @schedule = @schedule.sort_by(&:name).sort_by(&:start_time)
    
    
    if @range === @day
      @day_name = @day.strftime("%A")
      @month_name = @day.strftime("%B")
      @day_number = @day.strftime("%e")
      @year_number = @day.strftime("%Y")
      
      if @range === @day.tomorrow
        @tomorrow = @day.tomorrow
        @next = '/years/%s/%s/%s/schedule' % [@tomorrow.strftime("%Y"), @tomorrow.strftime("%m"), @tomorrow.strftime("%d")]
      else
        @next = '/years/%s/%s/%s/schedule' % [@start_date.strftime("%Y"), @start_date.strftime("%m"), @start_date.strftime("%d")]
      end
      
      if @range === @day.yesterday
        @yesterday = @day.yesterday
        @prev = '/years/%s/%s/%s/schedule' % [@yesterday.strftime("%Y"), @yesterday.strftime("%m"), @yesterday.strftime("%d")]
      else
        @prev = '/years/%s/%s/%s/schedule' % [@end_date.strftime("%Y"), @end_date.strftime("%m"), @end_date.strftime("%d")]
      end
      
    else
      # need error message - not a valid date for 2012
    end
    
    @page_title = "Schedule"
    @meta_data = {:page_title => "Schedule", :og_image => "http://www.chicagoideas.com/assets/application/logo.jpg", :og_title => "CIW Talks | Chicago Ideas Week", :og_type => "website", :og_desc => "CIW Talks are 90-minute sessions spread throughout the week that feature 3-6 speakers presenting on various themes. Talks take a variety of forms and may incorporate interviews, conversations or performances."}
   
  end
      
end
