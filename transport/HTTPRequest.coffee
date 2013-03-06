
request = require 'request'
url = require 'url'

class HTTP

  constructor: ( @client ) -> null

  emit: ( address, message ) =>

    try

      uri = url.format
        protocol: @client.options.protocol or 'http'
        host: @client.options.host
        port: @client.options.port
        pathname: address
        search: message.search or ''
        hash: message.hash or ''

      request
        url: uri
        method: message.method or 'GET'
        body: message.body or ''
        headers: message.headers or {}
        json: message.json or ( typeof message.body is 'object' )

      , ( err, response, body ) =>

        return @throw err if err

        @on response.statusCode,
          body: response.body
          headers: response.headers

    catch e
      return @throw e.message

  on: -> null
  throw: -> null

module.exports = HTTP