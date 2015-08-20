get '/' do
    #Know if this is connected to the auth.
  erb :welcome
end

get '/index' do
  erb :index
  #Check if the user is login in
end


get '/login' do
  #[param:string]
  #erb :login
  #Make sure that the user is authenticated
  redirect "/index"
end

get '/signup' do
# erb :signup

 redirect "/index"
end


post '/login' do
  #[param:string]
  #Check if the user cannot signup then direct him to the signup page by highlithing it

  redirect back
end


post '/signup' do
    member = User.up(
            :name   => params[:name],
            :email      => params[:email],
            :username   => params[:username],
            :password   => params[:password].crypt("abcde12345")
            )
        if member.errors.any?
            flash[:errors] = member.errors
            redirect back
        end
        session[:username] = params[:username]

           byebug
  redirect back
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

