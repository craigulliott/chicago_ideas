class Application::ChaptersController < ApplicationController
  
  # All Chapters
  def index
    
  end
  
  
  
  def show
    @chapter = Chapter.find(params[:id]) # get the chapter
    @talk = @chapter.talk # get the parent talk
    @chapters = @talk.chapters.all # get all the chapters
  end # end show
  
end
