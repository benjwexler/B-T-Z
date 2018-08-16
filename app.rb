require 'sinatra'
require 'sinatra/flash'
require 'sinatra/activerecord'
require './models/user.rb'
require './models/video.rb'



set :port, 9503



enable :sessions



#Sign In Form Route
# get '/signin' do
#     if session[:user_id] == nil
#         erb :sign_in
#     else
#         erb :signed_in_homepage
#     end 
# end

# get '/signin' do
    
#         erb :sign_in
    
# end

get '/signin' do
    
    erb :new_sign_in

end

#Sign In Route
post '/signin' do 
    user = User.find_by(username: params[:username].downcase)

    #If the user exists, and thier password is correct, then create a session and redirect them to a logged in page
    if user && user.password == params[:password]
        #Create the cookie with the users id
        session[:user_id] = user.id
        #Print a helpful message
        flash[:info] = "#{user.username} has logged in"
        #redirect to homepage
        redirect '/'
    else 
        flash[:warning] = "Your username does not exist or your password is not correct"
        redirect '/signin'
    end

end

#Sign Up Form Route

# get '/signup' do 
#     if session[:user_id] == nil 
#     erb :sign_up
#     else 
#     erb :signed_in_homepage
#     end 
# end

get '/signup' do 
    
    erb :new_sign_up
    
end

#Sign Up Route

post '/signup' do 
    user = User.create(
        first_name: params[:first_name],
        last_name: params[:last_name],
        username: params[:username].downcase,
        password: params[:password],
        email: params[:email].downcase,
        birth_month: params[:birth_month].to_i,
        birth_day: params[:birth_day].to_i,
        birth_year: params[:birth_year].to_i
    )
    session[:user_id] = user.id
    if params[:first_name].length > 0
    redirect '/'
    end 
end

# get '/' do
#     if session[:user_id] 
#         erb :signed_in_homepage
#     else
#         erb :signed_out_homepage
#     end
# end

get '/' do
    # session[:user_id] = 5
    # puts session[:user_id] == nil
    if User.exists?(:id => session[:user_id])
        @specific_user = User.find(session[:user_id])
    end 
    puts session[:user_id]
    erb :new_homepage
    

end

get '/users' do
    @users= User.all
    if User.exists?(:id => session[:user_id])
        @specific_user = User.find(session[:user_id])
    end 
    erb :new_all_users 
    # erb :users 
end

# get '/users' do
#     @users= User.all
#     erb :users  
# end

# get '/users/:id' do
#     if User.exists?(:id => params[:id])
#         @specific_user = User.find(params[:id])

#         @user_submissions = @specific_user.videos
        
#         erb :show_user
#     else  
#         redirect '/users'
#     end
# end

get '/users/:id' do
    if User.exists?(:id => params[:id])
        @specific_user = User.find(params[:id])

        @user_submissions = @specific_user.videos
        
        erb :new_show_user_submissions
    else  
        redirect '/users'
    end
end

# get '/users/:id' do
#     if User.exists?(:id => params[:id])
#         @specific_user = User.find(params[:id])

#         @user_submissions = @specific_user.videos
        
#         erb :show_user
#     else  
#         redirect '/users'
#     end
# end

delete '/users/:id' do 
    @specific_user = User.find(params[:id])
    @specific_user.destroy
    session[:user_id] = nil 
    redirect '/users'
end

get '/users/:id/edit' do

    # puts session[:user_id]
    # puts params[:id]
    # puts session[:user_id] && session[:user_id] == params[:id]
    @specific_user = User.find(session[:user_id])
    
        erb :new_edit_user
 
end

# get '/users/:id/edit' do

#     puts session[:user_id]
#     puts params[:id]
#     puts session[:user_id] && session[:user_id] == params[:id]
    
#     if (session[:user_id]) && (session[:user_id] == params[:id].to_i)
#         @specific_user = User.find(params[:id])
#         erb :edit_user
#     else
#         erb :sign_up
#     end
# end

get '/videos' do

    @videos = Video.all
    @user = User.all
    erb :latest_submissions
    
end

# get '/videos' do

#     @videos = Video.all
#     @user = User.all
#     erb :videos
    
# end

# get '/videos/new' do 
#     if session[:user_id] 
#         erb :new_video
#     else 
#         erb :sign_in
#     end 
# end

get '/videos/new' do 
    # if session[:user_id] 
        erb :new_new_video
    # else 
    #     erb :sign_in
    # end 
end

post '/videos' do
    regex = /youtube.com.*(?:\/|v=)([^&$]+)/
    if params[:video_url].length>0
        youtube_id = params[:video_url].match(regex)[1]
    end 
    Video.create(song_name: params[:song_name], artist_name: params[:artist_name], producer_name: params[:producer_name], genre: params[:genre], video_url: youtube_id, user_id: session[:user_id])
    # Skater.create(name: 'Tara Lipinski', nationality: 'USA', age: 36, photo_url: 'https://www.maxim.com/.image/t_share/MTQ4MjE2NjMyNDY3MDA2NjY5/tara-lipinski.jpg', is_favorite: true, average_score: 100)
    redirect '/videos'
end

get "/signout" do
    # this is the line that signs a user out
    session[:user_id] = nil
  
    # lets the user know they have signed out
    flash[:info] = "You have been signed out"
    
    # sleep 5.0
    redirect "/"
   
  end

put '/users/:id' do 
    @specific_user = User.find(params[:id])
    @specific_user.update(password: params[:password])
    redirect '/users/:id' 
end 

