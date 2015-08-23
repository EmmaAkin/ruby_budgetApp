get '/incomes-sort-by-amount' do
   @incomes = Income.order(amount: :asc)

#Implement a hidden form to alllow the post to update without refreshing the page

erb :sort_by_amount
end