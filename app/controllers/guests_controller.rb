class GuestsController < ApplicationController

  def index
    @guests = Guest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guests }
    end
  end

  def show    
    id = session[:guest_id]
    @guest = Guest.find(id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @guest }
    end
  end

  def new
    @guest = Guest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guest }
    end
  end

  def create
    @guest = Guest.new(:name=>"guest",:score=>0)
    @guest.save
    @guest[:name] = "guest#{@guest.id}"
    session[:guest_id]=@guest.id
    @guest.save
     
    respond_to do |format|
      if @guest.save
        format.html { redirect_to @guest }
        format.json { render json: @guest, status: :created, location: @guest }
      else
        format.html { render action: "new" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end 
  end

  def play
    @type = params[:type] 
    @count=0;
    @currentTweetArray=[];
    @tweetArray=[];
    @player=Guest.where(:id=>session[:guest_id]).first;
    if(@type == "football")
      @tweetArray=Football.where("done=?",0).all;
    else
      @tweetArray=Cricket.where("done=?",0).all;
    end
    
    @tweetArray.each do |key|
      key.id=key.id.to_s
      @chk=GuestVoteRecord.where(:guest_id=>@player.id,:tid=>key.id,:category=>@type).exists?;      
      if(!@chk)
        @currentTweetArray.push(key);
        @count+=1;
      else
      end
      break if @count==10
    end
    
    @player=Guest.where(:id=>session[:guest_id]).first
    @score_old = @player[:score];
    @currentId = @player[:id];
   end

  def destroy
    session[:guest_id]=nil
    redirect_to root_url
  end
  
  def putToken
   if(params[:type].to_s == "football")
     @a=(Football.where(:tweetId=>params[:tweetId].to_s).first)
   else
     @a=(Cricket.where(:tweetId=>params[:tweetId].to_s).first)
   end   
   @b=Guest.where(:id=>session[:guest_id]).first
   @c=GuestVoteRecord.new(:guest_id=>@b[:id],:category=>params[:type] ,:tid=>@a[:id],:vote=>params[:cat])
   @b[:score]+=1;
   @b.save
   @a[:category]=params[:cat]
   if(@a[:voteCat1]==nil)
     @a[:voteCat1]=0;
   end
   if(@a[:voteCat2]==nil)
     @a[:voteCat2]=0;
   end
   if(params[:cat]==0)
     @a[:voteCat1]=@a[:voteCat1]+1;
   else
     @a[:voteCat2]=@a[:voteCat2]+1;
   end
   if((@a[:voteCat1] + @a[:voteCat2])>=3)
     @a[:done]=1;
   end
   @a.save
   @c.save  
   
   render :json=>@a
  end
  
  def result
    @old = params[:old]
    player=Guest.where(:id=>session[:guest_id]).first
    @score = player[:score];
    @diff = @score.to_i - @old.to_i;
    @tweetArray = GuestVoteRecord.where(:guest_id=>session[:guest_id]).order("created_at DESC").limit(@diff.to_i).all
    @tweets = []
    @votes = []
    @tweetArray.each do |key|
      cat = key.category
      @votes.push(key.vote)
      if(cat == "football")
        twt = Football.where(:id=>key.tid).limit(1).all
        @tweets.push(twt[0][:tweetText]) 
      else
         twt = Cricket.where(:id=>key.tid).limit(1).all
        @tweets.push(twt[0][:tweetText])
      end
    end
  end
end
