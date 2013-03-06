
class EventEmitter

  constructor: () ->
    @callback = { '_': [] }
    @errorhandlers = []
    @proxies = []

    @send = @emit
    @recv = @on

  on: ( address, cb ) =>

    if typeof address is 'function'
      cb = address
      address = '_'

    if address instanceof RegExp
      address = address.toString()
      address = address.substring 1, address.length-1

    @callback[address] = [] unless Array.isArray @callback[address]
    @callback[address].push cb

    return @

  emit: ( address ) =>
    args = arguments
    @proxies.map ( emitter ) -> emitter.emit.apply emitter, args

    return @

  error: ( handler ) =>
    @errorhandlers.push handler

  throw: ( error ) =>
    @errorhandlers.map (handler) -> handler error

  proxy: ( emitter ) =>

    emitter.on = ( address, cb ) =>
      args = arguments
      for key, stack of @callback
        if new RegExp(key).exec address
          stack.map ( callback ) -> callback.apply null, args
      @callback['_'].map ( callback ) -> callback.apply null, args

    emitter.throw = @throw

    @proxies.push emitter

    return @

module.exports = EventEmitter