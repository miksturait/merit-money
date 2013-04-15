Ember.Handlebars.registerBoundHelper 'trend', (value, options) ->
    trendClasses = ""
    if value
        switch value
            when 'steady' then trendClasses = 'trend steady icon-minus'
            when 'upward' then trendClasses = 'trend upward icon-caret-up'
            when 'downward' then trendClasses = 'trend downward icon-caret-down'

       new Handlebars.SafeString("<i class=\'#{trendClasses}\'></i>")