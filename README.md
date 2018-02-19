# Taskapp
Attribution -> Professor Nat Tuck class Notes.


Design Choices Made: 
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