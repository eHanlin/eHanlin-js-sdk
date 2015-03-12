
###
# * @namespace
###
util =

  ###
   * @param {Object} obj
   * @type boolean
  ###
  isObject:( obj )-> return typeof obj is "object"

  ###
   * @param {Object} obj
   * @type boolean
  ###
  isArray:( obj )-> return Object.prototype.toString.call(obj) == "[object Array]"

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
   *
   *
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
  


