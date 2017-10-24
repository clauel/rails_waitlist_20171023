class RequestActivationsController < ApplicationController
  def edit
    request = Request.unconfirmed.find_by(email: params[:email])
    if request && request.authenticated?(:activation, params[:id])
      request.activate
      flash[:success] = "Congratulations, you have joined our waitlist!"
      SendConfirmationWorker.perform_in(2.minutes, request.id)
      redirect_to root_url
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
