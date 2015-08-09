request = require('request')
redis = require('./redis')
getToken = require('./redis_fun').getToken
addDevices = require('./redis_fun').addDevices
async = require('async')

class Check
  constructor:() ->
    @url = "https://www.gorouter.info/api-third-party/service/datacenter/get_connected_device?deviceId=8fb7d088-05f8-473d-8a85-509e59cc4541&appId=2882303761517367072&clientId=2882303761517367072&"



  getDevices:() ->
    self = @
    async.waterfall [
      # 获取token
      (callback) ->
        getToken (err, token) ->
          return console.log err if err

          callback(null, token)

      # 获取设备
      (token, callback) ->
        self.url += token.slice(7)
        console.log self.url

        request.get self.url, (err, res, body) ->
          data = JSON.parse(body)
          console.log data
          callback(null, data)

      # 记录设备信息
      (data, callback) ->
        devices = []
        for i in data.list
          tmp = {}
          mac = 'device-' + i.mac
          tmp[mac] = {}
          tmp[mac].ip = i.ip
          tmp[mac].origin_name = i.origin_name
          devices.push(tmp)

        console.log devices

        addDevices(devices)



    ]


c = new Check()

c.getDevices()