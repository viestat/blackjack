# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get 'playerHand'
      .on 'add', @checkForBust, @
    @get 'playerHand'
      .on 'stand', @checkScores, @

  checkForBust: =>
    console.log ' check for bust'
    playerScores = @get('playerHand').scores()
    playerScore = Math.min.apply(null, playerScores)

    if playerScore > 21
      @initialize()
      @trigger 'lose', @

  checkScores: ->
    # Flip dealer's first card
    @get 'dealerHand'
      .models[0].flip()

    # Get player and dealer scores
    playerScores = @get('playerHand').scores()
    dealerScores = @get('dealerHand').scores()

    # Find minimum of both possible scores
    playerScore = Math.min.apply(null, playerScores)
    dealerScore = Math.min.apply(null, dealerScores)
    
    # Standard rule: if dealer's score is less than 17, dealer must hit
    while dealerScore < 17
      @get('dealerHand').hit()
      # Recalculate dealer score
      dealerScores = @get('dealerHand').scores()
      dealerScore = Math.min.apply(null, dealerScores)
    
    # After dealer hits, if dealer has higher score, dealer wins
    if dealerScore > playerScore and dealerScore <= 21
      @initialize()
      @trigger 'lose', @
    else
      @initialize()
      @trigger 'win', @

