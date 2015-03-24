
###
 * @namespace
###
api =
  getComment:( user, type, target, limit = 10 )->

    ajax.jsonp "#{API_DOMAIN}user/#{user}/type/#{type}/target/#{target}/Comment", limit:limit

