class RelationshipsController < ApplicationController

def create
    @user =User.find(params[:relationship][:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_url)}
      format.js
    redirect_back(fallback_location: root_path)
    end
end

def destroy
    @user = User.find(params[:relationship][:followed_id])
    current_user.unfollow(@user)
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_url)}
      format.js
    redirect_back(fallback_location: root_path)
    end
end

end
