// Generated by CoffeeScript 1.8.0
(function() {
  var async, redis;

  redis = require('./redis');

  async = require('async');

  exports.setToken = function(token) {
    return redis.set("miwifi_token", token, function(err, res) {
      return console.log(err, res);
    });
  };

  exports.getToken = function(cb) {
    return redis.get('miwifi_token', function(err, res) {
      if (err) {
        return cb(err);
      }
      return cb(null, res);
    });
  };

}).call(this);

//# sourceMappingURL=redis_fun.js.map