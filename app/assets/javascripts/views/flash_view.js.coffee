App.FlashView = Ember.View.extend
  elementId: 'flash'
  classNames: 'alert'
  classNameBindings: ['alertType']

  alertType: (->
    status = @get('controller.status')
    "alert-#{status}" if status
  ).property('controller.status')

  messageDidChange: (->
    self = @
    message = @get('controller.message')

    if @get('controller.status')
      $('#flash')
        .empty()
        .show()
        .append(message)
        .fadeIn()
        .delay(2000)
        .fadeOut(->
          # we want flash to appear again
          self.set('controller.status', null)
        )
  ).observes('controller.status')