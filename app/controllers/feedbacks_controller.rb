class FeedbacksController < ApplicationController
  def index
    if current_user
      @feedbacks = Feedback.all
    elsif guest_user
      @feedbacks = GuestFeedback.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feedbacks }
    end
  end

  def show
    @feedback = Feedback.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feedback }
    end
  end

  def new
    @feedback = Feedback.new
  end

  def edit
    @feedback = Feedback.find(params[:id])
  end

  def create
    if current_user   
      @b=Tweeple.where(:id=>session[:tweeple_id]).first; 
      params[:feedback][:tweeple]=@b[:id];
      @fb = params[:feedback];
      @feedback = Feedback.new(:tweeple_id=>@fb[:tweeple],:content=>@fb[:content]);
      @feedback.save
      redirect_to "/", :notice=> "Thank you for your valuable feedback"
    elsif guest_user
      @b=Guest.where(:id=>session[:guest_id]).first; 
      params[:feedback][:tweeple]=@b[:id];
      @fb = params[:feedback];
      @feedback = GuestFeedback.new(:guest_id=>@fb[:tweeple], :email=>@fb[:email], :content=>@fb[:content]);
      @feedback.save
      redirect_to "/ghome", :notice=> "Thank you for your valuable feedback"
    end        
  end

  def update
    @feedback = Feedback.find(params[:id])
  end

  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy
  end
end
