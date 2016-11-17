var api = require('circonusapi2'),
    auth_token = '7339c41b-48ab-617e-8859-c60ab96edb90',
    app_name = 'Nomad';

var test = [];
api.setup(auth_token, app_name);

var callback = api.get("/metric?search=(active:1)*hashi*", null, function CIRC (code, error, body) {
  if ( ! error ) {
    console.log(body)
  }
  test = body;
  
});

function CIRC (code, error, body) {
	console.log("body is ", body);
}
