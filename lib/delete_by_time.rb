# because of the nature of this business, we very rarely want to actually destroy data
# so we use a deleted_at time stamp on the object.  If there is a time, then the model is deleted, NULL means the model is not deleted
module DeleteByTime

  # methods to create chainable arel logic
  def self.included(base)
    def base.not_deleted; where(:deleted_at => nil); end
    def base.deleted; where("deleted_at is not NULL"); end
  end

  # a useful boolean method to determine if the model has been deleted or not
  def deleted?
    deleted_at.present?
  end

end