require 'faker'

class EventController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
  before_action :current_user_is_admin?, only: [:edit, :destroy]

  def show
    @event = Event.find(params[:id])
    #Participation: Pas sur que ce soit bon
    @attendance = Attendance.all.where(event_id: params[:id])
  end

  def index
    @event = Event.all
  end

  def new
  p '*' * 60
  p params
  p '*' * 60
  @event = Event.new()
  end

  def create
    p '*' * 60
    p params
    p '*' * 60
    #start_date pas fait en select
    @event = Event.new(title: params[:title], start_date: Faker::Date.forward(25), description: params[:description], duration: params[:duration], price: params[:price], location: params[:location], admin: current_user)

    if @event.save
       flash[:success] = "Votre évènement a bien été créé!"
       redirect_to root_path
     else
       flash[:danger] = "Une erreur est survenue, veuillez réessayer"
       render :new
   end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    post_params = params.require(:event).permit(:title, :description, :location, :price)

    if @event.update(post_params)
      flash[:success] = "Votre évènement a été modifié!"
      redirect_to event_path(@event.id)
    else
      flash[:danger] = "Une erreur est survenue, veuillez réessayer"
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])

    if @event.destroy
      flash[:success] = "Votre évènement a été supprimé avec succès!"
      redirect_to :root
    else
      flash[:danger] = "Une erreur est survenue, veuillez réessayer"
      render event_path(@event.id)
    end
  end

  private

  def current_user_is_admin?
    unless current_user == Event.find(params[:id]).admin
      flash[:danger] = "Vous ne pouvez pas accéder à ceci!"
      redirect_to root_path
    end
  end

end
