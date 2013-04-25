# use require to load any .js file available to the asset pipeline
#= require application

describe "Adding kudos", ->
  currentUser = user1 = user2 = null
  beforeEach =>
    currentUser = Sks.CurrentUser.createRecord name: 'Wojtek Ryrych', email: 'wojtek.ryrych@gmail.com', kudosLeft: 20
    user = Sks.User.createRecord name: 'Rafał Bromirski', email: 'rafal@selleco.com'

  describe "adding a kudo without a comment", ->
    it "it subtract the kudosLeft", ->
      # simulate addKudo action?
      expect(currentUser.get('kudosLeft')).toBe 19


