# Ruby Word Guesser Game
Deployed to Heroku: https://ruby-wordguesser.herokuapp.com/ </br>
An interactive Word Guesser Game that generates a new random word each game. 
</br>Implemented an MVC patter using Sinatra to expose operations on the model. 
Testing of the game logic is done with Cucumber. Simulating browser actions with Capybara for integration tests. </br>
Designed routes for each RESTful action in the game:
- `GET /show` Show game state, allow player to enter guess; may redirect to Win or Lose
- `GET /new` Display form that can generate `POST /create`
- `POST /create` Start new game; redirects to Show Game after changing state
- `POST /guess` Process guess; redirects to Show Game after changing state
- `GET /win` Show "you win" page with button to start new game
- `GET /lose` Show "you lose" page with button to start new game

