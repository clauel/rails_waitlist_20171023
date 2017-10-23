class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      @request.send_activation_email
      flash[:info] = "Please check your email to activate your request to join the waiting list."
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

    def request_params
      params.require(:request).permit(:name, :email, :phone, :bio, :activated, :confirmed_at)
    end
end
