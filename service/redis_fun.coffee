redis = require('./redis')
async = require('async')

exports.setToken = (token) ->
  redis.set "miwifi_token", token, (err, res) ->
    console.log err , res

exports.getToken = (cb) ->
  redis.get 'miwifi_token', (err, res) ->
    return cb(err) if err

    cb(null, res)


