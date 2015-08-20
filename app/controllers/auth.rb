
get '/' do
    @title = "Home page"

    #Know if this is connected to the auth.
  erb :welcome
end

get '/index' do
  @title = "Home page"
  erb :index
  #Check if the user is login in
end


get '/login' do
    @title = "Login page"
    erb :welcome
  #[param:string]
  #erb :login
  #Make sure that the user is authenticated

end

get '/signup' do
    @title = "Signup page"
     erb :welcome
# erb :signup

end


post "/login" do
  if user.has_key?(params[:username])
    user = user[params[:username]]
    if user[:password] == params[:password].crypt("abcde12345")
      session[:username] = params[:username]
      redirect "/index"
    end
  end
  erb :error
end


post '/signup' do

         user = User.create(
            :name   => params[:name],
            :email      => params[:email],
            :username   => params[:username],
            :password   => params[:password].crypt("abcde12345")
            )

        session[:username] = params[:username]

        redirect '/index'
end

get "/logout" do
  session[:username] = nil
  redirect "/"
end

get '/income:sort_by_amount' do
    @title = "sort-by-amount"
 #erb :incomes_sort_by_amount
redirect "/index"
end

get '/expense:sort_by_amount' do
    @title = "sort-by-amount"
 #erb :expenses_sort_by_amount
redirect "/index"
end

get '/income:sort_by_name' do
 #erb :expenses_sort_by_name
redirect "/index"
end

get '/expense:sort_by_name' do
 #erb :expenses_sort_by_name
redirect "/index"
end


get '/table' do
# erb :table
redirect "/index"

end

get '/summary' do
 #erb :summary

end

