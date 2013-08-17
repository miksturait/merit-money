App.UsersListView = Ember.View.extend
  tagName: 'ul'
  elementId: 'users-list'
  templateName: 'users/users_list'

  didInsertElement: ->
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