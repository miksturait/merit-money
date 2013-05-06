# use require to load any .js file available to the asset pipeline

describe "Selleo Kudos System App", ->
  describe 'adding kudos', ->
    currentUser = null
    requests = []
    xhr = null

    # mock GET requests with Ember Fixture Adapter
    Sks.Adapter = DS.FixtureAdapter.extend
      simulateRemoteResponse: false

    Sks.store = DS.Store.create(revision: 12, adapter: Sks.Adapter.create())

    # setup
    beforeEach ->
      # mock POST requests with sinon server
      xhr = sinon.useFakeXMLHttpRequest();
      xhr.onCreate = (xhr) ->
        requests.push(xhr);

      currentUser = Sks.CurrentUser.find 1
      requests = []

    # teardown
    afterEach ->
      xhr.restore()

    it 'should add kudo to a user', ->
      # simulate adding kudo
      sksHelpers.addKudo()

      # request we expect from the server
      requests[0].respond 200, "Content-Type": "application/json", '{"status": "ok"}'

      expect(currentUser.get 'kudosLeft').toBe 19

      currentUser.set 'kudosLeft', 1
      sksHelpers.addKudo()

      requests[1].respond 200, "Content-Type": "application/json", '{"status": "ok"}'

      expect(currentUser.get 'kudosLeft').toBe 0

    it 'should not add kudo to a user', ->
      currentUser.set 'kudosLeft', 0
      sksHelpers.addKudo()

      requests[0].respond 200, "Content-Type": "application/json", '{"status": "error"}'

      expect(currentUser.get 'kudosLeft').toBe 0

    it 'should update badge on an avatar', ->
      $user = $ '.coworker:first'
      $badge = $user.find '.badge'
      badgeVal = parseInt($badge.text(), 10)

      currentUser.set 'kudosLeft', 20
      sksHelpers.addKudo()

      requests[0].respond 200, "Content-Type": "application/json", '{"status": "ok"}'

      expect(currentUser.get 'kudosLeft').toBe 19
      expect(badgeVal).toBe 1

    it 'should add kudo with a comment', ->
      # go to the user detailed page
      currentUser.set 'kudosLeft', 20

      Ember.run ->
        sksHelpers.addKudoWithAComment()
        requests[0].respond 200, "Content-Type": "application/json", '{"status": "ok"}'

      Ember.run ->
        expect(currentUser.get 'kudosLeft').toBe 15

        expect($('.kudo-received').length).toBe 4
        expect($('.kudo-received:last').text().replace(/\s{2,}/g, ' ').trim()).toBe '5: my comment'

  describe 'dashboard', ->
    currentUser = null

    # setup
    beforeEach ->
      currentUser = Sks.CurrentUser.find 1

    it 'should render trend correctly', ->
      # upward trend
      currentUser.set 'trend', 'upward'
      $icon = $('#dashboard').find('.trend.upward')

      expect($icon.text()).toBe '↗'

      # downward trend - todo issue GET again to test other trends

    it 'should render number of kudos you received last week', ->
      $kudosReceived = $ '#kudos-received'
      $lastWeek = parseInt $kudosReceived.find('.last-week').text(), 10

      expect($lastWeek).toBe 10

    it 'should render number of kudos you received since last bonus', ->
      $kudosReceived = $ '#kudos-received'
      $sinceBonus = parseInt $kudosReceived.find('.since-bonus').text().replace(/[()]/, '')

      expect($sinceBonus).toBe 23












