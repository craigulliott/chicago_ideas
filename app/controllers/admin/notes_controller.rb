class Admin::NotesController < Admin::AdminController

  # AdminController callbacks
  # ---------------------------------------------------------------------------------------------------------
  def pre_create(model)
    model.author = current_user if current_user
    return model
  end

  # we do not ever want to crete a note on a note, so this method simply overrides the note functionality from the admin controller
  def model_note(model, body)
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # retrieve the attachment (the file is not publicaly availiable on the internet)
  def attachment
    @note = Note.find(params[:id])
    storage = Fog::Storage.new({:provider => 'AWS', :aws_access_key_id => AWS_ACCESS_KEY_ID, :aws_secret_access_key => AWS_SECRET_ACCESS_KEY})
    redirect_to storage.get_object_https_url('socialkaty-note-attachments', @note.attachment.path, Time.now+120.seconds)
  end

end
