
###
 * @namespace
###
queryString =
  ###
   * @param {Object} data
   * @type String
  ###
  stringify:( data )->
    params = []

    for name, val of data
      if util.isArray val
        for childVal in val
          params.push "#{name}=#{childVal}"
      else
        params.push "#{name}=#{val}"

    params.join '&'

 
  ###
   * @param {String} url
   * @type Object
  ###
  parse:( url )->
    queryStrs = url.split '&'
    map = {}

    for queryStr in queryStrs
      {key, val} = queryStr.split '='

      if typeof map[key] is "undefined"
        map[key] = val
      else if !util.isArray map[key]
        map[key] = [map[key], val]
      else
        map[key].push val
      
