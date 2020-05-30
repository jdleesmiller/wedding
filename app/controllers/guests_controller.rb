# frozen_string_literal: true

class GuestsController < ApplicationController
  def new
    respond_to :html

    @guest = Guest.new
  end

  def create
    respond_to :html

    @guest = Guest.new(guest_params)
    unless ENV['RECAPTCHA_SECRET_KEY'].blank? || verify_recaptcha(model: @guest)
      render :new
      return
    end

    if @guest.save
      redirect_to guest_path(@guest)
    else
      existing_guest = Guest.find_by(email: guest_params[:email])
      if existing_guest
        @guest = existing_guest
        GuestMailer.welcome_back_email(@guest).deliver_now
        render :new_exists
      else
        render :new
      end
    end
  end

  def show
    respond_to :html

    @guest = Guest.find_by_id_token(params[:id])
  end

  def update
    @guest = Guest.find_by_id_token(params[:id])

    if @guest.update(guest_params)
      if @guest.attending?
        redirect_to guest_plus_ones_path(@guest)
      else
        redirect_to confirm_guest_path(@guest)
      end
    else
      render :show
    end
  end

  def confirm
    respond_to :html

    @guest = Guest.find_by_id_token(params[:id])
  end

  def complete
    respond_to :html

    @guest = Guest.find_by_id_token(params[:id])
    Guest.transaction do
      @guest.update!(guest_params)
      @guest.touch :confirmed_at
    end
    GuestMailer.confirmation_email(@guest).deliver_now
  end

  private

  def guest_params
    params.require(:guest).permit(
      :email, :first_name, :last_name, :attending, :diet, :songs, :notes
    )
  end
end
