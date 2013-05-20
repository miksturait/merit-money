Ember.Handlebars.registerBoundHelper 'trend', (value, options) ->
    trendClasses = ""
    trend = ""
    if value
        switch value
            when 'steady'
                trend = '↔'
                trendClasses = 'trend steady'
            when 'upward'
              trend = '↗'
              trendClasses = 'trend upward'
            when 'downward'
              trend = '↘'
              trendClasses = 'trend downward'

       new Handlebars.SafeString("<i class=\'#{trendClasses}\'>#{trend}</i>")

Ember.Handlebars.registerBoundHelper 'avatar', (gravatar) ->
  if gravatar
    new Handlebars.SafeString "<img src=\'#{gravatar}\' />"


$.fn.extend
  toggleView: (options) ->
    @defaults = {}
    settings = $.extend {}, @defaults, options

    return @each ->
      $this = $ this
      $this
        .toggleClass('form-visible', 'form-hidden')
        .find('.content-more').slideToggle()