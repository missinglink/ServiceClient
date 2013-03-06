
EventEmitter = require './EventEmitter'

class Client

  constructor: ( @transport, @options ) -> null

  event: ( onCreated ) ->
    event = new EventEmitter()
    event.proxy new @transport @
    onCreated event

module.exports = Client