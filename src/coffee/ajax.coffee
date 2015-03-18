
buildPipeByContentType = ( xhr, fn )->

  ( evt )->
    contentType = @getResponseHeader 'content-type'
    if contentType.toLowerCase() is 'application/json'
      data = JSON.parse @responseText
      fn.apply xhr, [evt, data]
    else
      fn.apply xhr, [evt]

###
 * @function
 * @param {String} url
 * @param {Object} settings
 * @type XMLHttpRequest
###
ajax = ( url, settings = {} )->

  xhr = new XMLHttpRequest()
  
  method = ( settings.method or 'get' ).toLowerCase()

  data = settings.data or {}
  {success, error, progress, headers} = settings
  isURLRequest = false

  switch method
    when 'get'
      data = if util.isObject data then queryString.stringify data else data
      isURLRequest = true

  if util.isFunction success then xhr.addEventListener 'load', buildPipeByContentType( xhr, success )
  if util.isFunction error then xhr.addEventListener 'error', error.bind xhr
  if util.isFunction progress then xhr.addEventListener 'progress', progress.bind xhr

  xhr.open method, url, true

  if headers and util.isObject headers
    xhr.setRequestHeader headerName, headerVal for headerName, headerVal of headers

  if isURLRequest then xhr.send() else xhr.send data

  xhr

###
 * @function
 * @param {Object} settings
 * @type function
###
buildAjax = ( settings )->
  
  ( url, params = {} )-> ajax url, util.clone( params, settings )

ajax.get = buildAjax {method:'get'}
ajax.post = buildAjax {method:'post'}
ajax.put = buildAjax {method:'put'}

EH[JSONP_KEY] = {}

###
 * @function
 * @param {String} url
 * @param {function} cb is optional
###
getScript = ajax.getScript = ( url, cb )->

  script = domUtils.createElement 'script'
  script.onload = ->
    script.remove()
    cb and cb()
  script.type = "text/javascript"
  script.src = url
  document.body.appendChild script

###
 * @param {String} url
 * @param {Object} params
 * @param {function} cb
 * @param {Object} settings
###
ajax.jsonp = ( url, params = {}, cb, settings = {callbackName:'callback'} )->
  key = randId()
  EH[JSONP_KEY][key] = ->
    cb and cb.apply null, arguments
    delete EH[JSONP_KEY][key]

  urlParams = util.clone {}, params
  urlParams[settings.callbackName] = "EH.#{JSONP_KEY}.#{key}"
  getScript "#{url}?#{queryString.stringify urlParams}"


