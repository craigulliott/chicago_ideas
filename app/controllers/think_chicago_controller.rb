class ThinkChicagoController < ApplicationController

  def index
    @meta_data = {:page_title => "ThinkChicago", :og_title => "Think Chicago | Chicago Ideas Week", :og_type => "website", :og_desc => "ThinkChicago challenges you to be a tech entrepreneur in The Second City, where cutting edge tech companies like Groupon, GrubHub, Threadless, and 37Signals already thrive."}
  end

end
