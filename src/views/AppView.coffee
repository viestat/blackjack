class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  templateStart: _.template '<div class="startScreen"> 
                              <div class="startMessage">B L A C K J A C K</div>
                              <form>
                                <input class="formText" id="nameForm" type="text" placeholder="Enter name"></input>
                                <input class="formText" id="moneyForm" type="text" placeholder="Enter $$$"></input>
                              </form>
                              <button class="play-button">PLAY</button>
                            </div>'

  templateWin: _.template '<div class="newGameWin zoomIn animated"> 
                            <div class="gameMessage winMessage"></div>
                            <button class="retry-button">Play Again?</button>
                          </div>'

  templateLose: _.template '<div class="newGameLose zoomIn animated"> 
                          <div class="gameMessage loseMessage"></div>
                            <button class="retry-button">Play Again?</button>
                          </div>'

  templateBettingArea: _.template '<div class="bettingArea">
                                    <h2> Money: $<%= window.playerMoney %> </h2>
                                    <div class="chip1" value="1"><h1>1</h1></div>
                                    <div class="chip10" value="10"><h1>10</h1></div>
                                    <div class="chip25" value="25"><h1>25</h1></div>
                                  </div>'

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .play-button': -> @getInputs()
    'click .retry-button': -> @render()

  initialize: ->
    @model.on 'gameStart', @renderStart, @
    @model.on 'restart', @render, @
    @model.on 'win', @renderWin, @
    @model.on 'lose', @renderLose, @
    @renderStart()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$el.addClass 'gameArea'

  renderWin: ->
    $('.hit-button').prop('disabled', true)
    $('.stand-button').prop('disabled', true)
    @$el.prepend(@templateWin)

  renderLose: =>
    $('.hit-button').prop('disabled', true)
    $('.stand-button').prop('disabled', true)
    @$el.prepend @templateLose()

  renderStart: =>
    @$el.prepend @templateStart()

  getInputs: =>
    window.playerName = $("#nameForm").val() or 'Mombito'
    window.playerMoney = $("#moneyForm").val() or '200'
    @render()
    $('body').append @templateBettingArea()
    $('.bettingArea').css('visibility', 'visible')
    $('.bettingArea').addClass('fadeInLeft animated')
    # @model.get('playerHand').initialize(@model.get('playerName'))
    # console.log @model.get('playerName')
    # console.log @model.get('playerMoney')