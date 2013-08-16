App.UserInUsersView = Em.View.extend
  tagName: 'li'
  templateName: 'user_in_users'
  classNames: 'coworker'
  attributeBindings: ['data-userid']
  'data-useridBinding': 'content.id'

  didInsertElement: ->
    $view = @$()

    # init raty plugin only once
    $ratyContainer = $view.find '.content-more .stars'
    ratyInitialized = $ratyContainer.data 'initialized'

    if !ratyInitialized
      $ratyContainer.raty
        path: 'assets/raty'
        size: 54
        score: 1
        hints: ['', '', '', '', '']

      $ratyContainer.data 'initialized', true

  showRow: ->
    id = @get 'content.id'
    $view = @$()
    $view.find('.content-more').slideDown -> $view.ScrollTo(offsetTop: 90)
    @get('controller.controllers.users').send 'setActiveRow', id

  activeRowObserver: (->
    @$('.content-more').slideUp() if not @get('controller.isActive')
  ).observes('controller.isActive')

  addKudo: ->
    $view = @$()
    $contentMore = $view.find '.content-more'
    kudoNum = $contentMore.find('.stars').raty('score') or 1
    kudoComment = $contentMore.find('.kudos-comment').val()
    userId = @get 'content.id'
    @get('controller.controllers.application').send 'addKudo', userId, kudoNum, kudoComment



