Sks.Store = DS.Store.extend
    revision: 11
    adapter: 'DS.RESTAdapter'

Sks.Store.registerAdapter 'Sks.User', DS.FixtureAdapter
