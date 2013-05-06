  # mock GET requests with Ember Fixture Adapter
  Sks.Adapter = DS.FixtureAdapter.extend
    simulateRemoteResponse: false

  Sks.store = DS.Store.create(revision: 12, adapter: Sks.Adapter.create())
  
module "/conversations",
  setup: ->
    Ember.run Sks, Sks.advanceReadiness
    # mock POST requests with sinon server
    #xhr = sinon.useFakeXMLHttpRequest();
    #xhr.onCreate = (xhr) ->
    # requests.push(xhr);

    currentUser = Sks.CurrentUser.find 1
    #requests = []

  teardown: ->
    Sks.reset()
    #xhr.restore()

test "/", ->
  expect(1);

  visit("/users/1").then ->
    ok(exists('#kudos-user-view'), "it was rendered");