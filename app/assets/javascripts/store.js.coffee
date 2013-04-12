Sks.Store = DS.Store.extend
    revision: 12
    adapter: 'DS.RESTAdapter'

Sks.Store.registerAdapter 'Sks.User', DS.FixtureAdapter