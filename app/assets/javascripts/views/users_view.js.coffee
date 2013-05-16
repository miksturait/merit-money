Sks.UsersView = Ember.View.extend
  elementId: 'kudos-users-view'

  didInsertElement: ->
    # show hidden content on more button click
    @.$('#users-list').on 'click', '.more', (event) ->
      $this = $ this
      $coworker = $this.parents '.coworker'
      $active = $coworker.siblings('.form-visible')

      # first hide all the active element
      $active.toggleView()

      # then show the clicked one
      $coworker.toggleView() if $coworker.get() isnt $active.get()

      event.preventDefault()