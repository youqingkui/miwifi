express = require('express')
request = require('request')
async = require('async')
logger = require('morgan')
path = require('path')
bodyParser = require('body-parser')
setToken = require('./service/redis_fun').setToken
app = express()

# view engine setup
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use logger('dev')
app.use express.static(path.join(__dirname, 'public'))


app.get '/auth', (req, res) ->
  console.log req.originalUrl
  url = 'http://account.xiaomi.com/oauth2/authorize?client_id=2882303761517367072&redirect_uri=http%3A%2F%2Fmiwifi.youqingkui.me%2Fcallback&response_type=token'
  return res.redirect(url)


app.all '/callback', (req, res) ->
  console.log req.method
  if req.method == 'GET'
    return res.render 'callback'

  console.log req.body
  if req.body.queryVal
    setToken(req.body.queryVal)
    return res.send "ok"
  else
    return "okok"


app.get '/ok', (req, res) ->
  return res.send "ok"


app.listen('80')
