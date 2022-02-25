class UserItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    @pay_form = PayForm.new
  end

  def create
    @pay_form = PayForm.new(user_item_params) 
    if @pay_form.valid?
      pay_item
      @pay_form.save
      redirect_to root_path
    else
      render:index
      end
    end

private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    if @item.user == current_user || @item.user_item.present?
      redirect_to root_path 
    end
  end

  def user_item_params
  params.require(:pay_form).permit(
    :post_code,
    :prefecture_id,
    :city,
    :house_number,
    :building_name,
    :phone_number
  ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
  Payjp.api_key = ENV['PAYJP_SECRET_KEY']
  Payjp::Charge.create(
    amount: @item.price,
    card: user_item_params[:token],
    currency: 'jpy')
  end
end