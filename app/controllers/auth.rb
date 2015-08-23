require 'byebug'
get '/' do

@title = "welcome"
    #Know if this is connected to the auth.
  erb :welcome
end

get '/login' do

#Go to the login view and show the html

   erb :login
end

post '/login' do

  #[param:string]
  #erb :login
  #Make sure that the user is authenticated

    #{}"Sumbited login form"
    user = User.where(:username => params[:username]).take
    if !user.nil? && user.password == params[:password].crypt('abcde12345')
      session[:username] = member.username

          redirect "/index"
    else

      #flash[:global] = {alert_type: 'alert-danger', message: "<strong>Oh Shit!</strong>
      #  That was a wrong combination of username and password."}

      redirect  "/login"
    end
  end


get '/logout' do

  #[param:string]
  #erb :login
  #Make sure that the user is authenticated
session.clear
  redirect "/login"
end





post '/signup' do

   @user = User.create(
            :name   => params[:name],
            :email      => params[:email],
            :username   => params[:username],
            :password   => params[:password].crypt("abcde12345")
            )

        session[:username] = params[:username]


  redirect "/index"
end



get '/index' do

@title = "BudgetApp"

#THis really need optimization to be able to find the sum total of the different models expense and income
    @expenses = Expense.order(title: :asc)
    @incomes = Income.order(title: :asc)
    sum = 0
    @sum_of_expense = @expenses.each do |expense|

          if expense.period == "Monthly"
                   sum += expense.amount * 12
          elsif expense.period == "Quarterly"
                   sum += expense.amount * 12
          elsif expense.period =="Yearly"
                   sum += expense.amount * 12
          else
        end
      end

   erb :index

end

put '/update/incomes/:id' do |expense_id|
    #Delete the expenses

       if session[:commit] == 'del'
           Expense.destroy(params[:id])
           byebug
           # If the update key is press this action is executed
       elsif session[:commit] == 'update'
   byebug
       Expense.update(params[:id], :amount => params[:amount], :period => params[:period])

        end


        redirect "/index"
  end

post '/delete/expenses/:id' do |expense_id|
    #Delete the expenses
        Expense.destroy(params[:id])

        redirect "/index"
  end

post '/update/expenses/:id' do |expense_id|
    #Delete the expenses
        Expense.update(params[:id], :amount => params[:amount], :period => params[:period])

        redirect "/index"
  end



put '/update/new/incomes' do
    #Check if the user is login in"

    check_exists = Income.where(:title => params[:title],:amount =>params[:amount], :period =>params[:period]).count
        if(check_exists == 0)
          #perform insert if book has not been previously added
                @incomes = Income.create(:title => params[:title], :amount => params[:amount], :period => params[:period])
                redirect '/index'

      else
                Income.where({ title: params[:title], amount: params[:amount] }).update_all(:title => params[:title], :amount =>params[:amount], :period =>params[:period])

              redirect "/index"

        end
  end


put '/update/new/expenses' do
    #Check if the user is login in"
    login
  check_exists=Expense.count(:title => params[:title],:amount =>params[:amount], :period =>params[:period])
        if(check_exists == 0)
          #perform insert if book has not been previously added
                Expense.create(:title=>params[:title], :amount=> 0, :period => 'Monthly')

                redirect '/index'
      else

                Expense.where(:title => params[:title],:amount =>params[:amount], :period =>params[:period]).update(params[:id], :amount=> params[:amount].to_i, :period => params[:period].to_s)
                # Edit the
               redirect "/index"

        end
end