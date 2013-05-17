Sks.KudoBadgeView = Em.View.extend
  tagName: 'span'
  classNames: 'badge badge-inverse'

  didInsertElement: ->
    self = @

    # listen for kudoAdded event broadcasted from ApplicationController
    @get('controller.controllers.application').on 'kudoAdded', (status, data) ->
      userId = self.$().parents('.coworker').data('userid')
      color1 = if status is 'success' then '#468847' else '#b94a48'
      color2 = 'black'
      speed = 500

      if userId is parseInt(data.userId)
        self.$()
          .animate(backgroundColor: color1, speed)
          .animate(backgroundColor: color2, speed)