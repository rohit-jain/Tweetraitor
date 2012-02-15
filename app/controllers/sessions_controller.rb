class SessionsController < ApplicationController
  def create  
    auth = request.env['omniauth.auth']  
    session[:access_token] = auth['credentials']['token']
    session[:access_secret] = auth['credentials']['secret']
    puts session[:access_secret].inspect
    tweeple = Tweeple.find_by_provider_and_uid(auth["provider"], auth["uid"]) || Tweeple.create_with_omniauth(auth)
    session[:tweeple_id] = tweeple.id  
    redirect_to root_url;      
  end  


  def show
    if session[:access_token] && session[:access_secret]
      @user = client.user
    else
      redirect_to root_url
    end
  end
     
  def play    
    @type = params[:type] 
    @count=0;
    @currentTweetArray=[];
    @tweetArray=[];
    @player=Tweeple.where(:id=>session[:tweeple_id]).first;
    if(@type == "football")
      @tweetArray=Football.where("done=?",0).all;
    else
      @tweetArray=Cricket.where("done=?",0).all;
    end
    @tweetArray.each do |key|
      @chk=VoteRecord.where(:tweeple_id=>@player.id, :tid=>key.id, :category=>@type).exists?;
      if(!@chk)
        @currentTweetArray.push(key);
        @count+=1;
      end
      break if @count==10
    end
    
    @player=Tweeple.where(:id=>session[:tweeple_id]).first
    @score_old = @player[:score];
    @currentId = @player[:id];
  end
  
  def destroy
    session[:tweeple_id]=nil
    redirect_to root_url
  end
  
  def putToken
   logger.debug "type: #{params[:type]} vote: #{params[:cat]} id: #{params[:tweetId]}"
   if(params[:type].to_s == "football")
     @a=(Football.where(:tweetId=>params[:tweetId]).first)
   else
     @a=(Cricket.where(:tweetId=>params[:tweetId]).first)
   end   
   @b=Tweeple.where(:id=>session[:tweeple_id]).first
   logger.debug "The object is #{@a[:id]}";
   @c=VoteRecord.new(:tweeple_id=>@b[:id],:tid=>@a[:id],:vote=>params[:cat],:category=>params[:type])
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
     @a[:voteCat1]+=1;
   else
     @a[:voteCat2]+=1;
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
    player=Tweeple.where(:id=>session[:tweeple_id]).first
    @score = player[:score];
    @diff = @score.to_i - @old.to_i;
    @tweetArray = VoteRecord.where(:tweeple_id=>session[:tweeple_id]).order("created_at DESC").limit(@diff.to_i).all
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
