
###
 * @class
 * @extend View
###

class WindowView extends View

  ###
   * @Override
   * @param {HTMLElement} el
  ###
  onCreate:( el )->

    View::onCreate.call @, el

    el.appendChild @buildElement()

  ###
  *
  ###
  buildElement:->

    (domUtils.createElementByHTML """
      <div class="eh-window-view">
        <div class="eh-window-content"></div>
      </div>
    """)[0]


#windowView = new WindowView()
#windowView.onCreate domUtils.createElement('div')
#document.body.appendChild windowView.el
