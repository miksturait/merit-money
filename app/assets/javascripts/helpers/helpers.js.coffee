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