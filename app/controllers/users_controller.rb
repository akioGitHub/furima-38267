class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    card = Card.find_by(user_id: current_user.id)
    if card.present?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
      card = Card.find_by(user_id: current_user.id) # ユーザーのid情報を元に、カード情報を取得      
      customer = Payjp::Customer.retrieve(card.customer_token) # 先程のカード情報を元に、顧客情報を取得
      @card = customer.cards.first
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      redirect_to action: "show"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
