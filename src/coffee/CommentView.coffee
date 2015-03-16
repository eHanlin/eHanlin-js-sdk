
###
 * @class
 * @extend View
###

class CommentView extends View

  ###
  # @Override
  # @param {HTMLElement} el
  ###
  onCreate:( el )->

    View::onCreate.call @, el

  ###
  # @return HTMLElement
  ###
  buildElement:->

    (domUtils.createElementByHTML """
      <div class="eh-comment-view">
        <div class="eh-line-block">
          <select id="" name="" class="eh-basic-select">
            <option>test</option>
            <option>test</option>
          </select>
        </div>
        <div class="eh-table-layout eh-full eh-line-block">
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

