Sks.UsersView = Ember.View.extend
  elementId: 'kudos-users-view'

  didInsertElement: ->
    showRow = ($row) ->
      $active = $row.siblings('.form-visible')

      # first hide all the active element
      $active.toggleView()

      #then show the clicked one
      if $row.get() isnt $active.get()
        $row
          .toggleView {}, ->
            $row.ScrollTo(offsetTop: 90)
        # TODO - use binding e.g expanding to update the view
          .find('.btn-more span').toggleClass('glyphicon-chevron-down', 'glyphicon-chevron-up')

    @.$('#users-list').on 'click', '.content, .btn-more', (event) ->
      $this = $ this

      # init raty plugin only once
      $ratyContainer = $this.closest('.coworker').find('.content-more .stars')
      ratyInitialized = $ratyContainer.data('initialized')

      if !ratyInitialized
        $ratyContainer.raty
          path: 'assets/raty'
          size: 54
          score: 1
          hints: ['', '', '', '', '']

        $ratyContainer.data('initialized', true)

      showRow $this.closest('.coworker') unless event.target is $this.get()

      return false

    @.$('#users-list').on 'focusin', '.kudos-comment', ->
      width = $(window).width()
      $('#dashboard').css(position: 'absolute', top: 0) if width < 980

    @.$('#users-list').on 'focusout', '.kudos-comment', ->
      width = $(window).width()
      $('#dashboard').css(position: 'fixed', top: 0) if width < 980

  statusDidChange: (->
    $expanded = $('#users-list').find '.form-visible'
    if @get('controller.status') is 'success' and $expanded.length is 1
      $ratyContainer = $expanded.find('.stars')
      $kudoComment = $expanded.find('.kudos-comment')
      $ratyContainer.raty('score', 1)
      $kudoComment.val('')

      # hide expanded on success
      $expanded.toggleView()
  ).observes('controller.status')