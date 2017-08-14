Rails.application.routes.draw do
  # get 'spiel/game'

  # get 'spiel/score'

  get 'game', to: 'spiel#game'
  get 'score', to: 'spiel#score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
