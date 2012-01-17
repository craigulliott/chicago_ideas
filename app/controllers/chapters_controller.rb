class ChaptersController < ApplicationController
  
  def index
    @chapters = Chapter.find(:all)
  end
  
  
  
  def show
    @chapter = Chapter.find(params[:id])
    @talk = @chapter.talk
    @chapters = @talk.chapters.all    
  end

  
end
