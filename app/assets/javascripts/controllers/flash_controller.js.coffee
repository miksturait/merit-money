App.FlashController = Ember.Controller.extend
  needs: ['application']
  statusBinding: 'controllers.application.status'
  valueBinding: 'controllers.application.kudoAddedNum'

  messages:
    success: "Success! You've added "
    error: 'Oops! An error has occured!'

  message: (->
    message = @get('messages')[@get('status')] || null
    message += "#{@get('value')} kudo(s)" if @get('status') is 'success'
    message
  ).property('status')