
###
 * @namespace
###
api =
  ###
   * @param {String} user
   * @param {String} type
   * @param {String} target
   * @param {Number} limit is optional
   * @type Deferred
  ###
  getComment:( user, type, target, limit = 10 )->

    ajax.jsonp "#{API_DOMAIN}user/#{user}/type/#{type}/target/#{target}/Comment", limit:limit

  ###
   * @param {String} user
   * @param {String} type
   * @param {String} target
   * @param {Object} data
   * @type Deferred
  ###
  putComment:( user, type, target, data = {} )->

    if data._id then delete data._id
    ajax.postJson "#{API_DOMAIN}user/#{user}/type/#{type}/target/#{target}/Comment", data:data

EH.api = api
