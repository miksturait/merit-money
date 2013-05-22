Sks.ApplicationView = Ember.View.extend
  statusDidChange: (->
    $expanded = $('#users-list').find '.form-visible'
    if @get('controller.status') is 'success' and $expanded.length is 1
      $ratyContainer = $expanded.find('.stars')
      $kudoComment = $expanded.find('.kudos-comment')
      $ratyContainer.raty('score', 1)
      $kudoComment.val('')
  ).observes('controller.status')