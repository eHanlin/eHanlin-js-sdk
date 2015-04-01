
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

    @headerEl = @el.querySelector "div.eh-window-header"
    @titleEl = @headerEl.querySelector "div.eh-window-title"

    if domUtils.getDataset( el ).enabledHeader
      domUtils.show @headerEl
    else
      domUtils.hide @headerEl


  ###
   *
  ###
  showTitle:-> domUtils.show @headerEl

  ###
   *
  ###
  hideTitle:-> domUtils.hide @headerEl

  ###
   * @param {String} title
  ###
  setTitle:( title )-> @titleEl.innerHTML = title

  ###
   * @type String
  ###
  getTitle:-> @titleEl.innerHTML

  ###
   *
  ###
  close:-> @fireEvent 'close', {}

  ###
   * @Override
  ###
  buildElement:->

    (domUtils.createElementByHTML """
      <div class="eh-window-view">
        <div class="eh-window-header">
          <div class="eh-window-title"></div>
          <a class="close-button" eh-event-click="close()">&times;</a>
        </div>
        <div class="eh-window-content" data-eh-transclude></div>
      </div>
    """)[0]

