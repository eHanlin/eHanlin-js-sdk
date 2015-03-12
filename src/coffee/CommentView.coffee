
###
 * @class
 * @extend View
###

class CommentView

  ###
  # @Override
  # @param {HTMLElement} el
  ###
  onCreate:( el )->

    View::onCreate.call @, el
    el.appendChild @buildElement()

  ###
  # @return HTMLElement
  ###
  buildElement:->

    (domUtils.createElementByHTML """
      <div class="eh-comment-view">
        <select id="" name="" class="eh-basic-select"></select>
        <div class="eh-table-layout eh-full">
          <div class="eh-table-cell">
            <textarea id="" name="" ></textarea>
          </div>
          <div class="eh-table-cell action-cell">
            <a class="eh-btn">送出</a>
          </div>
        </div>
      </div>
    """)[0]

#commentView = new CommentView()
#commentView.onCreate domUtils.createElement('div')
#document.body.appendChild commentView.el

