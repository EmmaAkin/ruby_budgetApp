require 'byebug'
def current_user

  if !session[:username]
        "guest"
  else
        return session[:username]
   end
end


  def login
    if session[:username].nil?
    #  return false

    redirect '/logout'
    else
      return true
    end
  end






