class RequestConfirmationsController < ApplicationController

  def edit
    request = Request.confirmed.find_by(email: params[:email])
    if request && request.authenticated?(:confirmation, params[:id])
      request.confirm
      flash[:success] = "Thank you for confirming your spot on our waitlist!"
      redirect_to root_url
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
