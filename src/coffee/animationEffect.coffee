
class Animation

  constructor:( @el )->
    @queue = []

  addCss_:( cssName )->
    @el.classList.add 'eh-animation'
    @el.classList.add cssName
    @queue.push cssName
    
  resetCss_:->
    while cssName = @queue.shift()
      @el.classList.remove cssName

  cssEffect:( name, cb )->
    @resetCss_()
    @addCss_ name

    if cb
      el = @el
      oneCb = ->
        cb and cb()
        el.removeEventListener TRANSITION_END, oneCb

      el.addEventListener TRANSITION_END, oneCb
    
    


animationEffect =

  ###
   * @param {HTMLElement} el
   * @type Animation
  ###
  createAnimation:( el )->

    animation = util.data el, 'animation'

    if animation
      animation
    else
      animation = new Animation el
      util.data el, 'animation', animation
      animation

  ###
   * @param {HTMLElement} el
   * @param {function} callback
  ###
  fadeIn:( el, callback )->
    animation = @createAnimation el
    domUtils.show el
    animation.cssEffect 'eh-fade-in', callback

  ###
   * @param {HTMLElement} el
   * @param {function} callback
  ###
  fadeOut:( el, callback )->
    animation = @createAnimation el
    animation.cssEffect 'eh-fade-out', ->
      domUtils.hide el
      callback and callback()

