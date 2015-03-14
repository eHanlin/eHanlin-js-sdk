
###
 * @namespace
###
domUtils =

  ###
   * @param {String queryStr}
   * @type Array[]
  ###
  query:( queryStr )-> document.querySelectorAll( queryStr )

  ###
   * @param {HTMLElement}
   * @type boolean
  ###
  isElement:( obj )->

    try
      #Using W3 DOM2 (works for FF, Opera and Chrom)
      obj instanceof HTMLElement
    
    catch e
      #Browsers not supporting W3 DOM2 don't have HTMLElement and
      #an exception is thrown and we end up here. Testing some
      #properties that all elements have. (works on IE7)
      (typeof obj is "object") and
        (obj.nodeType is 1) and (typeof obj.style is "object") and
        (typeof obj.ownerDocument is "object")
    

  ###
   * @param {String tag}
   * @type HTMLElement
  ###
  createElement:( tag )-> document.createElement( tag )

  ###
   * @param {String html}
   * @type HTMLElement
  ###
  createElementByHTML:( html )->

    el = @createElement('div')
    children = null
    el.innerHTML = html
    children = el.children
    util.each((i, child)->
      el.removeChild( child )
    )
    children





