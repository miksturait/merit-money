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

Ember.Handlebars.registerBoundHelper 'kudosReceivedNum', (user, options) ->
  kudosTotal = 0
  if user
    weeklyKudos = user.get 'kudoReceiveds'
    weeklyKudos.forEach (item) ->
      kudosTotal += item.get 'value'

    kudosTotal