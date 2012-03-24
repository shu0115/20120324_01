# coding: utf-8
class TopController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @tweet = Tweet.new
    @tweets = Tweet.includes( :user ).all
  end

  #--------#
  # create #
  #--------#
  def create
    @tweet = Tweet.new( params[:tweet] )
    @tweet.user_id = session[:user_id]

    unless @tweet.save
      flash[:alert] = "ポストに失敗しました。"
    end
    
    redirect_to( action: "index" )
  end

  #--------#
  # delete #
  #--------#
  def delete
    tweet = Tweet.where( user_id: session[:user_id], id: params[:id] ).first
    tweet.destroy
    
    redirect_to( action: "index" )
  end
end