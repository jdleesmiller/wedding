# frozen_string_literal: true

class PlusOnesController < ApplicationController
  before_action do
    @guest = Guest.find_by_id_token(params[:guest_id])
  end

  def new
    respond_to :html
    @plus_one = @guest.plus_ones.new
  end

  def create
    respond_to :html
    @plus_one = @guest.plus_ones.new(plus_one_params)
    if @plus_one.save
      redirect_to guest_plus_ones_path(@guest)
    else
      render :new
    end
  end

  def index
    respond_to :html
    @plus_ones = @guest.plus_ones.order(:first_name, :last_name)
  end

  def edit
    @plus_one = @guest.plus_ones.find(params[:id])
    respond_to :html
  end

  def update
    @plus_one = @guest.plus_ones.find(params[:id])

    if @plus_one.update(plus_one_params)
      redirect_to guest_plus_ones_path(@guest)
    else
      render :edit
    end
  end

  def destroy
    respond_to :html
    @plus_one = @guest.plus_ones.find_by(id: params[:id])
    @plus_one&.destroy
    redirect_to guest_plus_ones_path(@guest)
  end

  private

  def plus_one_params
    params.require(:plus_one).permit(:first_name, :last_name, :diet, :child)
  end
end
