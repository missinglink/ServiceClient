
service =
  transport:
    HTTPRequest: require './transport/HTTPRequest'
  Client: require './Client'

client = new service.Client( service.transport.HTTPRequest, {
  protocol: 'https',
  host: 'graph.facebook.com'
});

client.event ( event ) ->

  event.on /200|201/, -> console.log 'A HTTP Success Code!'
  event.on /[45]\d{2}/, -> console.log 'An HTTP Error Occured!'
  event.error ( error ) -> console.log 'Error! ' + error
  event.recv console.log

  event.emit '/version',
    method: 'GET'
    headers: { 'Content-Type': 'application/json' }
    body: { foo: 'bar' }