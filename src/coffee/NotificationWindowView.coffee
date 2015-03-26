
###
 * @class
 * @extend View
###
class NotificationWindowView extends View

  ###
   * @Override
   * @param {HTMLElement} el
  ###
  onCreate:( el )->

    View::onCreate.call @, el

    @window = @findViewByName 'window'
    @message = @el.querySelector '.message'

  ###
   * @param {String} message
  ###
  setMessage:( message )-> @message.innerHTML = message

  ###
   * @type String
  ###
  getMessage:-> @message.innerHTML

  ###
   * @param {String} title
  ###
  setTitle:( title )-> @window.setTitle title

  ###
   * @type String
  ###
  getTitle:-> @window.getTitle()

  ###
   *
  ###
  close:->
    animationEffect.fadeOut @el, => @el.remove()

  ###
   * @Override
  ###
  buildElement:->

    (domUtils.createElementByHTML """
      <div data-eh-action="window" eh-event-close="close()" data-enabled-header="true">
        <div class="message"></div>
      </div>
    """)[0]


#window.addEventListener 'load', ->
#  console.log 'load'
#  window.notificationWindowView = new NotificationWindowView()
#  notificationWindowView.onCreate()
#  document.body.appendChild notificationWindowView.el

