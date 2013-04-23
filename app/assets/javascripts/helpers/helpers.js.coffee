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