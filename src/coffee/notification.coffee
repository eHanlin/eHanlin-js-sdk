
###
 * @namespace
###
notification = (()->

  notificationListEl = (domUtils.createElementByHTML """
    <div class="eh-notification-list"></div>
  """)[0]

  window.addEventListener 'load', -> document.body.appendChild notificationListEl

  ###
   * @param {String} text
   * @param {String} title
  ###
  message:( text, title, opts = {ms:2000} )->

    notificationWindowView = new NotificationWindowView()
    row = (domUtils.createElementByHTML """
      <div class="eh-notification-row"></div>
    """)[0]
    notificationWindowView.onCreate row
    notificationWindowView.setMessage text
    notificationWindowView.setTitle title
    notificationListEl.appendChild notificationWindowView.el

    setTimeout (-> notificationWindowView.close()), opts.ms

)()
