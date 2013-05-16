Sks.FlashView = Em.View.extend
  elementId: 'flash'
  classNames: 'alert'

  didInsertElement: ->
    $this = this.$ this

    Sks.get('ApplicationController').on('kudoAdded', (status, data) ->
      console.log 'foo'
      if status is 'success'
        message = "You've added #{data.value} kudo{s}!"
      else
        message = "Oops! An error has occured!"

      $this
        .removeClass('alert-error alert-success')
        .addClass("alert-#{status}")
        .empty()
        .append(message)
        .show()
        .fadeIn()
        .delay(2000)
        .fadeOut()
    )