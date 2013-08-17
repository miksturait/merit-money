App.UserEntryMoreView = Ember.View.extend
  classNames: ['content-more', 'row']
  templateName: 'users/user_entry_more'

  didInsertElement: ->
    $view = @$()
    $comment = $view.find '.kudos-comment'
    $dashboard = $ '#dashboard'

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

    # todo - find better solution to make dashboard fixed
    windowWidth = $(window).width()
    $comment
    .on('focusin', -> $dashboard.css(position: 'absolute', top: 0) if windowWidth < 980)
    .on 'focusout', -> $dashboard.css(position: 'fixed', top: 0) if windowWidth < 980

  isExpandedChanged: (->
    view = @
    $view = @$()
    isExpanded = @get 'controller.isExpanded'
    if isExpanded
      $view.slideDown -> view.get('parentView').$().ScrollTo(offsetTop: 90)
    else
      $view.slideUp()
  ).observes('controller.isExpanded')