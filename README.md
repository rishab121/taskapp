# Taskapp
Attribution -> Professor Nat Tuck class Notes.


Design:
There are three pages in App.html
First is where user can view the tasks assigned to him.
Second is to check the manager and underlings of user.
Third is management where user can become manger of the users for whom there
is no manager.
Choices Made: 
1. User can assign only himself as manager to other users for whom there is no other managers.
2. User can himself as his manager if there is no other manager of him to assign tasks.
3. Both the manager and underling to which the task was can edit the tasks. As underling might want to update the time. But only the manager can delete the task. 
Instead of storing whole user in the session stored only user_id, as sessions are maintained
in cookies, By storing only user_id there will be no issue with the cookie size. Also storing the user_id 
will give me updated tasks everytime as every page will have to make query to get user. This behavior 
is important because other users can also assign tasks.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
