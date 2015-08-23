require 'byebug'
#Check this part later
post '/delete' do

    user = User.find (params[:id])
    p user
   user.destroy
    redirect '/index'

end


get '/table' do
# erb :table


redirect "/index"

end

get '/summary' do
 #erb :summary
redirect "/index"
end