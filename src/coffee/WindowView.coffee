
###
 * @class
 * @extend View
###

class WindowView extends View

  ###
  *
  ###
  buildElement:->

    (domUtils.createElementByHTML """
      <div class="eh-window-view">
        <div class="eh-window-content" data-eh-transclude></div>
      </div>
    """)[0]

