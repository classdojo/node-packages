events   = require "events"
resolver = require "./resolver" 

class Loader
  
  ###
  ###

  constructor: (@_loadable, @_loaders) ->
    @_required = @_loadable.require or []
    @_load     = @_loadable.load


  ###
  ###

  require: (path) ->
    @_required

  ###
  ###

  load: () ->
    return @exports if @exports

    modules = []

    for moduleName in @_required
      modules.push @_loaders.load(moduleName)

    @exports = @_load(modules...) ? true




class Loaders extends events.EventEmitter

  ###
  ###

  constructor: (@packages) ->
    @_resolvers = []
    @_loaders = {}

  ###
  ###

  resolve: (path) ->
    return @_loaders[path] if @_loaders[path]
    for loadable in resolver.resolve(path)
      @_loaders[loadable.name] = new Loader(loadable, @)

  ###
  ###

  load: (name) ->

    @resolve(name)

    loader = @_loaders[name]

    unless loader
      throw new Error "cannot load '#{name}'"

    @packages[name] = loader.load()

  ###
  ###

  loadAll: (next) ->
    for name of @_loaders
      @load(name)



module.exports = Loaders