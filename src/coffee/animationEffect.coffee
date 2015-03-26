
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

  cssEffect:( name )->
    @resetCss_()
    @addCss_ name
    
    


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
    animation.cssEffect 'eh-fade-in'
    el.addEventListener 'transitionend', ->
      callback and callback()

  ###
   * @param {HTMLElement} el
   * @param {function} callback
  ###
  fadeOut:( el, callback )->
    animation = @createAnimation el
    animation.cssEffect 'eh-fade-out'
    el.addEventListener 'transitionend', ->
      callback and callback()

