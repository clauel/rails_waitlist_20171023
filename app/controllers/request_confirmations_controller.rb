class RequestConfirmationsController < ApplicationController
  before_action :get_request,         only: [:edit]
  before_action :check_expiration, only: [:edit]

  def edit
    if @request && @request.authenticated?(:confirmation, params[:id])
      @request.confirm
      flash[:success] = "Thank you for confirming your spot on our waitlist! You are at position #{@request.waitlist_position}."
      SendConfirmationWorker.perform_in(20.seconds, @request.id)
      redirect_to root_url
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

  private

    def get_request
      @request = Request.confirmed.find_by(email: params[:email])
    end

    def check_expiration
      if @request.confirmation_reset_expired?
        flash[:danger] = "The confirmation link has expired. You are no longer on our waitlist."
        redirect_to root_url
      end
    end
end
