class ItemsController < ApplicationController
  def index
  end






  private

  def message_params
    params.require(:item).permit(:content, :item).merge(user_id: current_user.id)
  end
end
