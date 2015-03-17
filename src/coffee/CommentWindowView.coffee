
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
  #
  ###
  onSubmit:->
    console.log arguments

  ###
   * @Override
  ###
  buildElement:->

    (domUtils.createElementByHTML """
      <div data-eh-action="window">
        <div data-eh-action="comment" eh-event-submit="onSubmit()"></div>
      </div>
    """)[0]


