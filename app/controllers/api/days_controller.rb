class Api::DaysController < ApplicationController
  def index
    respond_to do |format|
      format.json {
          json_models Day.all
      }
    end
  end
  def show
    respond_to do |format|
      format.json {
        json_model Day.find(params[:id])
      }
    end
  end
end
