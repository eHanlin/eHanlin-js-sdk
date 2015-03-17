
###
 * @class
###
class Observer

  ###
   * @type Object
  ###
  getEvent_:-> if @events_ then @events_ else @events_ = {}

  ###
   * param {String} name
   * param {function} callback
   * param {Object} context
  ###
  removeEvent_:( name, callback, context )->
    delIndex = null

    check = (()->

      if callback and context
        ( eventCallback, eventContext )-> callback is eventCallback and context is eventContext
      else
        ( eventCallback )-> callback is eventCallback
    )()

    for event, index in events[name]
      if check callback, context
        delIndex = index
        break

    if delIndex then events[name].splice delIndex, 1


  ###
   * @param {String} name
   * @param {*} params...
  ###
  trigger:( name )->
    params = util.copyArray arguments
    params.shift()
    events = @getEvent_()
    removeFuncs = []

    for event, index in events[name]
      event.callback.apply ( event.context or null ), params
      removeFuncs.push index

    pointer = 0

    for index in removeFuncs
      pointer -= index
      events[name].splice pointer, 1

  ###
   * @param {String} name
   * @param {function} callback
   * @param {Object} context
   * @param {boolean} once is inner variable
  ###
  on:( name, callback, context, once = false )->

    events = @getEvent_()

    if !events[name] then events[name] = []

    events.push {name:name,callback:callback,context:context}

  ###
   * @param {String} name
   * @param {function} callback
   * @param {Object} context
  ###
  off:( name, callback, context )->

    events = @getEvent_()

    switch arguments.length
      when 0 then delete events[name] for name of events
      when 1 then delete events[name]
      when 2, 3 then @removeEvent_ name, callback, context
      
  ###
   * @param {String} name
   * @param {function} callback
   * @param {Object} context
  ###
  once:( name, callback, context )->
    params = util.copyArray arguments
    params.push true
    @on.apply @, params

