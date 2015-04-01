
###
 * @param {XMLHttpRequest} xhr
 * @param {function} success
 * @param {function} error
 * @param {Deferred} deferred
###
buildPipeByContentType = ( xhr, success, error, deferred )->

  ###
   * @private
   * @function
  ###
  forwardParams = ->
    success and success.apply xhr, arguments
    deferred.resolve.apply deferred, arguments

  ( evt )->
    if @readyState is 4 and @status is 200
      contentType = @getResponseHeader 'content-type'
      if contentType.toLowerCase() is 'application/json'
        data = JSON.parse @responseText
        forwardParams evt, data
      else
        forwardParams evt, @responseText
    else
      error and error.apply xhr, arguments
      deferred.reject.apply deferred, arguments

###
 * @param {XMLHttpRequest} xhr
 * @param {function} fn
 * @param {Deferred} deferred
###
buildErrorPipe = ( xhr, fn, deferred )->

  ( evt )->
    fn and fn.apply xhr, arguments
    deferred.reject.apply deferred, arguments

###
 * @param {Object} header
 * @param {*} data
 * @type String
###
getDataByHeader = ( header, data )->

  if !util.isString data
    for headerName, headerVal of header
      if /content-type/i.test headerName
        if /application\/json/i.test headerVal
          return JSON.stringify data
        else if /application\/x-www-form-urlencoded/i.test headerVal
          return queryString.stringify data

    data.toString()
  else
    data

###
 * @function
 * @param {String} url
 * @param {Object} settings
 * @type XMLHttpRequest
###
ajax = ( url, settings = {} )->

  xhr = new XMLHttpRequest()
  deferred = Deferred()
  
  method = ( settings.method or 'get' ).toLowerCase()

  data = settings.data or {}
  {success, error, progress, headers} = settings
  isURLRequest = false

  switch method
    when 'get'
      data = if util.isObject data then queryString.stringify data else data
      isURLRequest = true

  xhr.addEventListener 'load', buildPipeByContentType( xhr, success, error, deferred )
  xhr.addEventListener 'error', buildErrorPipe( xhr, error, deferred )
  if util.isFunction progress then xhr.addEventListener 'progress', progress.bind xhr

  xhr.open method, url, true

  if headers and util.isObject headers
    xhr.setRequestHeader headerName, headerVal for headerName, headerVal of headers

  if isURLRequest then xhr.send() else xhr.send getDataByHeader( headers, data )

  xhr.done = deferred.done.bind deferred
  xhr.fail = deferred.fail.bind deferred
  xhr

###
 * @function
 * @param {Object} settings
 * @type function
###
buildAjax = ( settings )->
  
  ( url, params = {} )-> ajax url, util.clone( params, settings )

ajax.get = buildAjax {method:'get'}
ajax.post = buildAjax {method:'post', headers:{"Content-type":"application/x-www-form-urlencoded"}}
ajax.put = buildAjax {method:'put'}

ajax.postJson = buildAjax {method:'post', headers:{"Content-type":"application/json"}}

EH[JSONP_KEY] = {}

###
 * @function
 * @param {String} url
 * @param {function} cb is optional
###
getScript = ajax.getScript = ( url, cb )->

  script = domUtils.createElement 'script'
  script.onload = ->
    parentNode = script.parentNode
    parentNode.removeChild script
    cb and cb()
  script.type = "text/javascript"
  script.src = url
  document.body.appendChild script

###
 * @param {String} url
 * @param {Object} params
 * @param {function} cb
 * @param {Object} settings
 * @type Deferred
###
ajax.jsonp = ( url, params = {}, cb, settings = {callbackName:'callback'} )->
  deferred = Deferred()
  key = randId()
  EH[JSONP_KEY][key] = ->
    cb and cb.apply null, arguments
    deferred.resolve.apply deferred, arguments
    delete EH[JSONP_KEY][key]

  urlParams = util.clone {}, params
  urlParams[settings.callbackName] = "EH.#{JSONP_KEY}.#{key}"
  getScript "#{url}?#{queryString.stringify urlParams}"
  deferred

