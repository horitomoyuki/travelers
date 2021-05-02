class FootprintsController < ApplicationController

  def index
  end

  def create
    Footprint.create(footprint_params)
  end

  private

  def footprint_params
    params.require(:footprint).permit(:visiter_id, :visited_id)
  end
end
