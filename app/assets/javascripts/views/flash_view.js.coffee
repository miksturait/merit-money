Sks.FlashView = Em.View.extend
  elementId: 'flash'
  classNames: 'alert'

  didInsertElement: ->
    self = @

    # listen for kudoAdded event broadcasted from ApplicatoinController
    @get('controller.controllers.application').on 'kudoAdded', (status, data) ->
      if status is 'success'
        message = "You've added #{data.value} kudo(s)!"
      else
        message = "Oops! An error has occured!"

      self.$()
        .removeClass('alert-error alert-success')
        .addClass("alert-#{status}")
        .empty()
        .append(message)
        .show()
        .fadeIn()
        .delay(2000)
        .fadeOut()