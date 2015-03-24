
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
   * @param {String} tag
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

  ###
   * @param {HTMLElement} el
   * @type Object
  ###
  getStyles:( el )->
    if el.ownerDocument.defaultView.opener
      el.ownerDocument.defaultView.getComputedStyle el, null
    else
      window.getComputedStyle el, null

  ###
  # @param {HTMLElement} el
  # @param {Object} attrs
  ###
  css:( el, attrs, extra = false )->

    if typeof attrs is "string"
      val = @getStyles( el )[ attrs ]
      if extra is true then parseFloat val else val
    else
      for key, attr of attrs
        el.style[key] = attr

  ###
   * @param {HTMLElement} el
  ###
  hide:( el )->
    display = @css el, 'display'
    util.data el, 'originalDisplay', display
    @css el, {'display': 'none'}

  ###
   * @param {HTMLElement} el
  ###
  show:( el )->
    @css el, {'display': (util.data( el, 'originalDisplay' ) or 'block')}

  ###
  # @param {HTMLElement} el
  ###
  offset:( el )->
    box = el.getBoundingClientRect()
    ownDoc = el.ownerDocument
    docElem = ownDoc.documentElement
    top:box.top + ( docElem.scrollTop ) - ( docElem.clientTop || 0 )
    left:box.left + ( docElem.scrollLeft ) - ( docElem.clientLeft || 0 )

  ###
   * @param {HTMLElement} el
  ###
  position:( el )->
    parentOffset =
      top:0
      left:0

    if @css( el, 'position' ) is 'fixed'
      el.getBoundingClientRect()
    else

      offsetParent = @offsetParent el.offsetParent

      if offsetParent and !@nodeName( offsetParent, 'html' )
        parentOffset = domUtils.offset offsetParent

      offset = @offset el

      parentOffset.top += @css offsetParent, 'borderTopWidth', true
      parentOffset.left += @css offsetParent, 'borderLeftWidth', true

      top:  offset.top  - parentOffset.top -  @css el, 'marginTop', true
      left: offset.left - parentOffset.left - @css el, 'marginLeft', true

  ###
   * @param {HTMLElement} el
  ###
  offsetParent:( el )->
    docElem = document.documentElement
    offsetParent = offsetParent or docElem

    while offsetParent and ( !@nodeName( offsetParent, 'html' ) and @css( offsetParent, "position" ) is "static" )
      offsetParent = offsetParent.offsetParent
    offsetParent or docElem

  ###
   * @param {HTMLElement} el
   * @param {String} name
  ###
  nodeName:( el, name )-> el.nodeName and el.nodeName.toLowerCase() is name.toLowerCase()

  ###
  # @param {HTMLElement} el
  # @param {String} name
  # @param {*} detail
  ###
  fireEvent:( el, name, detail )->
    event = new CustomEvent name, { 'detail': detail, bubbles:true}
    el.dispatchEvent event
