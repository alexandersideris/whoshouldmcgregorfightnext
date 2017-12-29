class FightsController < ApplicationController
  def index
     @fighters = Fighter.all
     @fights = Fight.all
  end
end
