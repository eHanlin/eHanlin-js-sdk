
###
 * @class
 * @extend View
###

class CommentWindowView extends View

  ###
   * @Override
   * @param {HTMLElement} el
  ###
  onCreate:( el )->

    View::onCreate.call @, el

  ###
   * @Override
  ###
  buildElement:->

    (domUtils.createElementByHTML """
      <div data-eh-action="window">
        <div data-eh-action="comment"></div>
      </div>
    """)[0]


