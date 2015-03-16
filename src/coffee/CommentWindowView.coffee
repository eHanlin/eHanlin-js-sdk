
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

    windowView = new WindowView()
    commentView = new CommentView()
    windowView.onCreate @el
    commentView.onCreate()
    windowView.setContent commentView.el

#commentWindowView = new CommentWindowView
#commentWindowView.onCreate domUtils.createElement('div')
#document.body.appendChild commentWindowView.el

