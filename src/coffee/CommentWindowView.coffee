
###
 * @class
 * @extend View
###

class CommentWindowView

  ###
   * @Override
   * @param {HTMLElement} el
  ###
  onCreate:( el )->

    View::onCreate.call @, el

    windowView = new WindowView()
    commentView = new CommentView()
    windowView.onCreate el
    commentView.onCreate el
