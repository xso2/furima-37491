class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] 

  def index
    @items  = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end




  private

  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :introduction,
      :category_id,
      :price,
      :item_condition_id,
      :postage_payer_id,
      :prefecture_id,
      :preparation_day_id
    ).merge(user_id: current_user.id)
  end
end
