class FightsController < ApplicationController
  respond_to :json
  respond_to :html

  def index
    @fighters = Fighter.all
    @fights = Fight.order("upvotes DESC").order("RANDOM()").first(50)
    if current_user != nil
      @fights.each do |fight|
        if current_user.voted_for? fight
          fight.has_voted = 'true'
        else
          fight.has_voted = 'false'
        end
      end
    else
      @fights.each do |fight|
        fight.has_voted = 'false'
      end
    end
  end

  def get_fights

    @fights = []
    if params[:division].to_s == 'None' && params[:superfights].to_s!='true'
      @fights = Fight.where("fighter_one_id = "+params[:the_fighter].to_s + " or fighter_two_id = "+params[:the_fighter].to_s).order("upvotes DESC").order("RANDOM()")
    elsif params[:division].to_s != 'Popular' && params[:superfights].to_s != 'true'
      @fights = Fight.where(division: +params[:division]).order("upvotes DESC").order("RANDOM()")
    elsif params[:superfights].to_s == 'true'
      @fights = Fight.where("division = "+"'Superfight'").order("upvotes DESC").order("RANDOM()")
    else
      @fights = Fight.order("upvotes DESC").order("RANDOM()").first(50)
    end
    
    if current_user != nil
      @fights.each do |fight|
        if current_user.voted_for? fight
          fight.has_voted = 'true'
        else
          fight.has_voted = 'false'
        end
      end
    else
      @fights.each do |fight|
        fight.has_voted = 'false'
      end
    end
    
    render json: @fights
  end

  def vote
    @fight = Fight.find(params[:id])
    @user = User.find(params[:user_id])
    @fight.liked_by @user
    @fight.upvotes = @fight.upvotes + 1
    @fight.save
    redirect_to '/'
  end

  def unvote
    @fight = Fight.find(params[:id])
    @user = User.find(params[:user_id])
    @fight.unliked_by @user
    @fight.upvotes = @fight.upvotes - 1
    @fight.save
    redirect_to '/'
  end

  def subscribe
    Subscription.create(name: params[:name], user_id: params[:user_id] )
    redirect_to '/'
  end

  def show
    redirect_to '/'
  end

end
