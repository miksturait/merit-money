Sks.UsersView = Ember.View.extend
  elementId: 'kudos-users-view'

  didInsertElement: ->
    showRow = ($row) ->
      $active = $row.siblings('.form-visible')

      # first hide all the active element
      $active.toggleView()

      #then show the clicked one
      if $row.get() isnt $active.get()
        $row.find('.more span').toggleClass 'glyphicon-chevron-down', 'glyphicon-chevron-up'
        $row
          .toggleView {}, ->
            $row.ScrollTo(offsetTop: 90)

    # show hidden content on more button click
    @.$('#users-list').on 'click', '.more', (event) ->
      $row = $(this).parents '.coworker'
      showRow $row

      return false

    @.$('#users-list').on 'click', '.content', (event) ->
      $this = $ this

      if $(event.target).is '.btn-add'
        event.preventDefault()
        return

      showRow $this.closest('.coworker') unless event.target is $this.get()

      return false

    @.$('#users-list').on 'focusin', '.kudos-comment', ->
      width = $(window).width()
      $('#dashboard').css(position: 'absolute', top: 0) if width < 980

    @.$('#users-list').on 'focusout', '.kudos-comment', ->
      width = $(window).width()
      $('#dashboard').css(position: 'fixed', top: 0) if width < 980