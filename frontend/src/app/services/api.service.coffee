app.service 'Api', ($http, $q) ->
  get: (url, params={}) ->
    @request('GET', url, params, null)

  post: (url, params={}, data) ->
    @request('POST', url, params, data)

  put: (url, params={}, data) ->
    @request('PUT', url, params, data)

  request: (method, url, params={}, data) ->
    defer = $q.defer()

    $http(method: method, url: url, params: params, data: data, cache: false)
    .success (data) -> defer.resolve data
    .error (msg, code) -> defer.reject "#{code} #{msg}"

    defer.promise

  idsToObjects: (ids, objects) ->
    ids.map (id) -> _.findWhere objects, id: id
