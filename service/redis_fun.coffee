redis = require('./redis')
async = require('async')

exports.setToken = (token) ->
  redis.set "miwifi_token", token, (err, res) ->
    console.log err , res

exports.getToken = (cb) ->
  redis.get 'miwifi_token', (err, res) ->
    return cb(err) if err

    cb(null, res)

exports.addDevices = (devices) ->
  devices.forEach (device) ->
    for key of device
      redis.exists key, (err, res) ->
        if not res
          redis.hmset key, {ip:device[key].ip, origin_name:device[key].origin_name}, (err, row) ->
            console.log err, row
        else
          console.log "find", key

      redis.exists 'deviceSet', (err, res) ->
        if not res
          redis.sadd 'deviceSet', key






