#= require application
# require sinon-1.4.2
# require sinon-server-1.6.0
# require jasmine-sinon
#= require_tree .
#= require_self

Sks.setupForTesting()
Sks.injectTestHelpers()

exists = (selector) ->
  return !!find(selector).length