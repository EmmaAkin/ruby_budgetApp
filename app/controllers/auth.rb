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
@yearly_incomes = 0
 @yearly_expenses = 0
#THis really need optimization to be able to find the sum total of the different models expense and income
    @expenses = Expense.order(title: :asc)
    @incomes = Income.order(title: :asc)

# Get the yearly savings, income and expenses.
@incomes.each do |income|
       if income.period== "Monthly"

        @yearly_incomes += income.amount .to_i* 12
       elsif income.period== "Quarterly"
       @yearly_incomes += income.amount.to_i * 3
       else
            @yearly_incomes += income.amount.to_i
       end
     end
 @expenses.each do |expense|
       if expense.period == "Monthly"
        @yearly_expenses += expense.amount.to_i * 12
       elsif expense.period == "Quarterly"
        @yearly_expenses += expense.amount.to_i * 3
       else
            @yearly_expenses += expense.amount.to_i
       end
    end

@yearly_savings = @yearly_incomes - @yearly_expenses

   erb :index

end

put '/update/incomes/:id' do |income_id|
    #Delete the expenses
    login
       if params[:commit] == 'del'
           Income.destroy(params[:id])

           # If the update key is press this action is executed
       elsif params[:commit] == 'update'

       Income.update(params[:id], :amount => params[:amount], :period => params[:period])

        end


        redirect "/index"
  end

  put '/update/expenses/:id' do |expense_id|
    #Delete the expenses
    login
       if params[:commit] == 'del'
           Expense.destroy(params[:id])

           # If the update key is press this action is executed
       elsif params[:commit] == 'update'

       Expense.update(params[:id], :amount => params[:amount], :period => params[:period])

        end


        redirect "/index"
  end



put '/update/new/incomes' do
    #Check if the user is login in"
     login
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



