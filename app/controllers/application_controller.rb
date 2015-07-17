class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_cart
    unless Cart.find_by(session[:cart_id])
      @cart = Cart.create
      session[:cart_id] = @cart.id
      @cart
    else
      @cart = Cart.find_by(session[:cart_id])
    end
  end

end
