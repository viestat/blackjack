assert = chai.assert

describe 'hand', ->
  deck = null
  playerHand = null
  dealerHand = null

  beforeEach ->
    deck = new Deck()
    playerHand = deck.dealPlayer()
    dealerHand = deck.dealDealer()

  describe 'player hand', ->
    it 'should have two cards', ->
      assert.strictEqual playerHand.length, 2

  describe 'dealer hand', ->
    it 'should have two cards', ->
      assert.strictEqual dealerHand.length, 2

  describe 'hit', ->
    it 'should increase hand size', ->
      playerHand.hit()
      assert.strictEqual playerHand.length, 3 

  describe 'stand', ->
    it 'should show dealer cards', ->
      dealerHand.stand()
      flip = dealerHand.models[0].flip()
      expect(flip).to.have.been.called();