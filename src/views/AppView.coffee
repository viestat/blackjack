class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '
  templateWin: _.template '<div class="newGameWin"> 
                          <div class="gameMessage winMessage">
                          </div>
                          <button class="retry-button">Play Again?</button>
                        </div>'
  templateLose: _.template '<div class="newGameLose"> 
                          <div class="gameMessage loseMessage">
                          </div>
                          <button class="retry-button">Play Again?</button>
                        </div>'


  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .retry-button': -> @render()

  initialize: ->
    @model.on 'restart', @render, @
    @model.on 'win', @renderWin, @
    @model.on 'lose', @renderLose, @
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$el.addClass 'gameArea'

  renderWin: ->
    @$el.prepend @templateWin()

  renderLose: ->
    @$el.prepend @templateLose()