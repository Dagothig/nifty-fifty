let express = require('express');

let app = express();

app.use(express.static(__dirname + '/public', { extensions: ['html'] }));

let SERVER_PORT = process.env.PORT || 8080;
app.listen(SERVER_PORT, () => console.log('Server listening on port', SERVER_PORT));
