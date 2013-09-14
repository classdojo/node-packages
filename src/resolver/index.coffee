resolverFactory = require "./factory"
toarray         = require "toarray"

exports.resolve = (path) ->
  toarray resolverFactory.create(path).resolve()

