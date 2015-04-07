
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

    if !( /none/i.test display )
      util.data el, 'originalDisplay', display
      @css el, {'display': 'none'}

  ###
   * @param {HTMLElement} el
  ###
  show:( el )->

    display = @css el, 'display'
    originalDisplay = util.data( el, 'originalDisplay' )
    originalDisplay = if originalDisplay and (! /none/i.test(originalDisplay)) then originalDisplay else 'block'

    if /none/i.test display then @css el, {'display': originalDisplay}

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
    evt = document.createEvent "Event"
    evt.initEvent name, true, false
    evt.detail = detail
    el.dispatchEvent evt
    #The IE is not support
    #event = new CustomEvent name, { 'detail': detail, bubbles:true}
    #el.dispatchEvent event

  ###
   * @param {HTMLElement} el
  ###
  remove:( el )->
    parentNode = el.parentNode
    if parentNode then parentNode.removeChild el

  ###
   * @param {HTMLElement} el
   * @param {String} key
   * @type Object
  ###
  getDataByDatasetKey:( el, key )->
    data = {}
    for name, val of @getDataset( el )
      rName = new RegExp "^#{key}", "i"
      if rName.test name
        dataName = name.replace( rName, "" )
        names = dataName.split("")
        names[0] = names[0].toLowerCase()
        data[names.join('')] = if !isNaN( val ) and val != '' then Number val else val
    data

  ###
   * @param {String} key
   * @type String
  ###
  getDatasetAttributeNameByKey_:( key )->
    filterKey = key.replace /^data-/, ''
    names = filterKey.split '-'
    datasetName = ''

    for name, index in names
      if index is 0
        datasetName = name
      else
        partNames = name.split ''
        datasetName = datasetName + (partNames.shift().toUpperCase()) + partNames.join('')

    datasetName

  ###
   * @param {HTMLElement} el
   * @type Object
  ###
  getDataset:( el )->

    if el.dataset
      dataset = el.dataset
    else
      dataset = {}

      for attribute in el.attributes
        nodeName = attribute.nodeName
        if /data-/.test nodeName
          datasetName = @getDatasetAttributeNameByKey_ nodeName
          dataset[datasetName] = attribute.value
          
    dataset

  ###
   * @param {HTMLElement} el
   * @param {Number} width
  ###
  width:( el, width )-> if arguments.length > 1 then el.style.width = "#{width}px" else el.clientWidth

  ###
   * @param {HTMLElement} el
   * @param {Number} height
  ###
  height:( el, height )-> if arguments.length > 1 then el.style.height = "#{height}px" else el.clientHeight

