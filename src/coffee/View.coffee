
###
 * @class
###
class View

  ###
   * @param {HTMLElement} el
  ###
  onCreate:( el )->

    dom = @buildElement()

    if el

      @el = el
      @el.appendChild( dom )

    else

      @el = dom

    @eventBinder = new EventBinder()
    XEHML.parse @el
    @registerEvent()

  ###
   * @param {Number} width
  ###
  width:( width )->
    params = util.copyArray arguments
    params.unshift @el
    domUtils.width.apply domUtils, params

  ###
   * @param {Number} height
  ###
  height:( height )->
    params = util.copyArray arguments
    params.unshift @el
    domUtils.height.apply domUtils, params

  ###
   *
  ###
  destroy:()->

  ###
   * @type HTMLElement
  ###
  buildElement:()-> domUtils.createElementByHTML('<div></div>')[0]

  ###
   *
  ###
  registerEvent:()->

    el = @el
    @eventBinder.register el, @

  ###
   * @param {String} name
   * @param {*} detail
  ###
  fireEvent:( name, detail )->

    domUtils.fireEvent @el, name, detail

  ###
   * @param {String} viewName
   * @type View
  ###
  findViewByName:( viewName )->
    viewEl = @el.querySelector( '[data-eh-action="' + viewName + '"]' )
    util.data( viewEl, 'view' )


