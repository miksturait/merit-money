Ember.Handlebars.registerBoundHelper 'trend', (value, options) ->
    trendClasses = ""
    if value
        switch value
            when 'steady'
                trendClasses = 'trend steady icon-minus'
            when 'upward'
              trendClasses = 'trend upward icon-caret-up'
            when 'downward'
              trendClasses = 'trend downward icon-caret-down'

       new Handlebars.SafeString("<span class=\'#{trendClasses}\'></span>")

Ember.Handlebars.registerBoundHelper 'avatar', (gravatar) ->
  if gravatar
    new Handlebars.SafeString "<img src=\'#{gravatar}\' />"


$.fn.extend
  toggleView: (options, callback) ->
    @defaults = {}
    settings = $.extend {}, @defaults, options

    return @each ->
      $this = $ this
      $this
        .toggleClass('form-visible', 'form-hidden')
        .find('.content-more').slideToggle 'normal', callback