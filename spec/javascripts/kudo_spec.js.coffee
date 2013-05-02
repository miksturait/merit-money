# use require to load any .js file available to the asset pipeline
#= require application

describe "Adding kudos", ->
  currentUser = user1 = user2 = null
  beforeEach =>
    Ember.testing = true;
    Ember.run ->
      route = Sks.ApplicationRoute.create()
      currentUser = Sks.CurrentUser.createRecord name: 'Wojtek Ryrych', email: 'wojtek.ryrych@gmail.com', kudosLeft: 0
#      user = Sks.User.createRecord name: 'Rafał Bromirski', email: 'rafal@selleco.com'

  describe "adding a kudo without a comment", ->
    it "it subtract kudosLeft", ->
      Ember.run ->
        # simulate addKudo action?
        console.log($('.coworker:first').find('.btn-primary').click())

      expect(currentUser.get('kudosLeft')).toBe -1


