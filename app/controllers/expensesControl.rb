#We can create a new expenses
#The users would need to client on adding a new expenses from a list of expenses


# You can sort expenses by amount
get '/expenses-sort-by-amount' do
   @expenses = Expense.order(amount: :asc)

#Implement a hidden form to alllow the post to update without refreshing the page

erb :sort_by_amount
end
# You can sort expenses by date

# You can sort expense by alphabetic order which is the DEFAULT

# You can delete expenses

