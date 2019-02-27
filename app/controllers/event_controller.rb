class EventController < ApplicationController
  def index
    @events = Event.all
  end

  def show
  end

  def new
  end

  def create
  end
end
