class AttendanceController < ApplicationController
  def index
  end

  def show
  end

  def new
    @event = Event.find(params[:event_id])
    @attendance = Attendance.new()
  end

  def create
    @event = Event.find(params[:event_id])

    @amount = @event.price * 100

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

    @attendance = Attendance.create(stripe_customer_id: charge[:customer], event: @event, user: current_user) unless charge[:customer].nil?
    flash[:info] = "Vous participez maintenant à l'évènement"
    redirect_to @event

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to @event
    end
end
