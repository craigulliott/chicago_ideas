class BhsiController < ApplicationController

  def index
    @meta_data = {:page_title => "Bluhm/Helfand Innovation Fellowship", :og_title => "Bluhm/Helfand Innovation Fellowship | Chicago Ideas Week", :og_type => "website", :og_desc => "The Bluhm/Helfand Social Innovation Fellowship @ Chicago Ideas Week, recognizes three young socially-conscious leaders who have developed innovative ventures addressing social needs, and provides them with exposure to nationally recognized business and community leaders, funding to support their cause, and a platform for growth."}
  end

  def fellows
    @meta_data = {:page_title => "Bluhm/Helfand Innovation Fellowship", :og_title => "Bluhm/Helfand Innovation Fellowship | Chicago Ideas Week", :og_type => "website", :og_desc => "The Bluhm/Helfand Social Innovation Fellowship @ Chicago Ideas Week, recognizes three young socially-conscious leaders who have developed innovative ventures addressing social needs, and provides them with exposure to nationally recognized business and community leaders, funding to support their cause, and a platform for growth."}
  end
  
  def previous_fellows
    @meta_data = {:page_title => "Bluhm/Helfand Innovation Fellowship", :og_title => "Bluhm/Helfand Innovation Fellowship | Chicago Ideas Week", :og_type => "website", :og_desc => "The Bluhm/Helfand Social Innovation Fellowship @ Chicago Ideas Week, recognizes three young socially-conscious leaders who have developed innovative ventures addressing social needs, and provides them with exposure to nationally recognized business and community leaders, funding to support their cause, and a platform for growth."}
  end
  
  def nominate_form
    @meta_data = {:page_title => "Bluhm/Helfand Innovation Fellowship Nomination Form", :og_title => "Bluhm/Helfand Innovation Fellowship Nomination Form | Chicago Ideas Week", :og_type => "website", :og_desc => "The Bluhm/Helfand Social Innovation Fellowship @ Chicago Ideas Week, recognizes three young socially-conscious leaders who have developed innovative ventures addressing social needs, and provides them with exposure to nationally recognized business and community leaders, funding to support their cause, and a platform for growth."}
  end

end
