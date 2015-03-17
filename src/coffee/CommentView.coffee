
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
    @textarea = @el.querySelector 'textarea'
    @select = @el.querySelector 'select'

  ###
   * @type String
  ###
  getText:-> @textarea.value

  ###
   * @type String
  ###
  getSelect:-> @select.value

  ###
   * @param {String} val
  ###
  setText:( val )-> @textarea.value = val

  ###
   * @param {*} val
  ###
  setSelect:( val )-> @select.value = val

  ###
   * @param {Object[]} values
  ###
  renderSelect:( values )->
    html = ""
    for val in values
      html += """
        <option value="#{val.val}">#{val.text}</option>
      """
    @select.innerHTML = html

  ###
  #
  ###
  onSubmit:-> @fireEvent 'submit', {test:124}

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
            <textarea name="" ></textarea>
          </div>
          <div class="eh-table-cell action-cell">
            <a class="eh-btn" eh-event-click="onSubmit()">送出</a>
          </div>
        </div>
      </div>
    """)[0]

