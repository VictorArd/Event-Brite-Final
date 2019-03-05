require 'faker'

class EventController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def show
    @event = Event.find(params[:id])
    #Participation: Pas sur que ce soit bon
     @attendance = Attendance.all.where(event_id: params[:id])
  end

  def index
    @events = Event.all
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
       redirect_to event_path(current_user.events.last.id)
     else
       flash[:danger] = "Une erreur est survenue, veuillez réessayer"
       render :new
   end
  end

  def subscribe

    @event = Event.find(params[:id])

    @amount = @event.price

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd',
    })

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

  end

end
