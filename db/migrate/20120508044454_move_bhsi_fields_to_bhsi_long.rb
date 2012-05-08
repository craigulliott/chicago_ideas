class MoveBhsiFieldsToBhsiLong < ActiveRecord::Migration
  def up
    
    BhsiApplication.all.each do |ba|
      if ba.bhsi_longtext.nil?
        
        ba.build_bhsi_longtext()
        ba.bhsi_longtext.about_yourself = ba.about_yourself
        ba.bhsi_longtext.social_venture_description = ba.social_venture_description
        ba.bhsi_longtext.venture_launched = ba.venture_launched
        ba.bhsi_longtext.number_people_affected = ba.number_people_affected
        ba.bhsi_longtext.explain_number = ba.explain_number
        ba.bhsi_longtext.organizational_development = ba.organizational_development
        ba.bhsi_longtext.strong_midwest_connections_explained = ba.strong_midwest_connections_explained
        ba.bhsi_longtext.additional_comments = ba.additional_comments
        ba.bhsi_longtext.three_standout_statistics = ba.three_standout_statistics
      
      end
    end
  
  end
end
