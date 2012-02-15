class HomeController < ApplicationController
  def index
      if signed_in?
          # singed_in function is defined inside Application Controller 
          @user=client.user
      end
  end
end
