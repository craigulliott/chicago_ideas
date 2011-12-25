class Admin::SponsorshipLevelsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @section_title = 'List'
    @sponsorship_levels = SponsorshipLevel.by_name
  end

end
