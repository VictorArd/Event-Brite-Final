class Admin::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin

  def index
    @events = Event.all.where(validated: nil)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if params[:validated].present?
      @event.update(validated: params[:validated])
      flash[:info] = "L'évènement à été validé"
      redirect_to admin_events_path
    else
      flash[:warning] = "Vous n'avez pas coché la case pour valider l'évènement"
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:warning] = "L'évènement à été supprimé"
    redirect_to admin_events_path
  end


  private

  def check_if_admin
    unless current_user.is_admin
      flash[:danger] = "Vous n'êtes pas Administrateur"
      redirect_back(fallback_location: root_path)
    end
  end
end
