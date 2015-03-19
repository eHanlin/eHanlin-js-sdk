
###
# * @namespace
###
util =

  ###
   * @param {Object} obj
   * @type boolean
  ###
  isObject:( obj )-> typeof obj is "object"

  ###
   * @param {Object} obj
   * @type boolean
  ###
  isArray:( obj )-> Object.prototype.toString.call(obj) == "[object Array]"

  ###
   * @param {function} func
   * @type boolean
  ###
  isFunction:( func )-> typeof func is "function"

  ###
   * @param {Object} obj
   * @type boolean
  ###
  isArrayLike:( obj )->

    length = obj.length

    if typeof obj is "function" then return false

    return @isArray( obj ) or
           length is 0 or ( typeof length is "number" && length > 0 && ( length - 1 ) of obj )

  ###
   * @param {Object} obj
   * @param {function} callback
  ###
  each:( obj, callback )->
    value = null
    i = 0

    if @isArrayLike( obj )

      for val in obj

        value = callback.call val, i, val

        if value is false then break

    else

      for i of obj

        value = callback.call obj[i], i, obj[i]

        if value is false then break


  ###
   * @param {Object} target
   * @param {Object} obj
   * @type Object
  ###
  clone:( deep, cloneObj, copyObj )->

    target = null
    obj = null

    if typeof deep != "boolean"
      target = deep
      obj = cloneObj
    else
      target = cloneObj
      obj = copyObj
    

    for i of obj

      if util.isArray obj[i]

        target[i] = if util.isArray( target[i] ) then target[i] else []

      else if util.isObject obj[i]

        target[i] = if util.isObject target[i] then target[i] else {}

      if deep and util.isObject( obj[i] ) then @clone( target[i], obj[i] ) else target[i] = obj[i]

    return target
  

  ###
   * @param {Array} array
   * @type Array
  ###
  copyArray:( array )->

    newArray = []

    newArray[index] = array[index] for val, index in array
    return newArray

  ###
   * @param {function} constructor
   * @param {function} superConstructor
  ###
  inherits:( constructor, superConstructor )-> @clone( true, constructor.prototype, superConstructor.prototype )

  ###
   * @param {HTMLElement} el
   * @type boolean
  ###
  hasData:( el )-> if el[DATA_KEY] then true else false

  ###
   * @param {HTMLElement} el
   * @param {String} key
  ###
  removeData:( el, key )->

    if @hasData

      if key then delete el[DATA_KEY][key] else delete el[DATA_KEY]
      

  ###
   * @param {HTMLElement} el
   * @param {String} key
   * @param {*} value
  ###
  data:( el, key, value )->
    
    data = if !@hasData el then el[DATA_KEY] = {} else el[DATA_KEY]

    if arguments.length is 3 then data[key] = value else data[key]



