
###
 * @class
 * @extend View
###

class ScoreView extends View

  ###
   * @Override
   * @param {HTMLElement} el
   *
  ###
  onCreate:( el )->

    View::onCreate.call @, el

    el.appendChild @buildElement()
    @onLoadData()
    @registerEvent()
    
  ###
   *
  ###
  onLoadData:()->
    @data_ =
      status:''

    @renderByData()

  ###
   * @param {String} status
  ###
  setStatus:( status )->
    @data_.status = status

  ###
   * @type String
  ###
  getStatus:()->
    return this.data_.status

  LIKE:'like',
  UNLIKE:'unlike',

  ###
   *
  ###
  renderByData:()->
    status = @data_.status
    el = @el
    likeEl = el.querySelector('.eh-like')
    unlikeEl = el.querySelector('.eh-unlike')

    switch status
      when 'like'
        likeEl.classList.add('active')
        unlikeEl.classList.remove('active')

      when 'unlike'
        likeEl.classList.remove('active')
        unlikeEl.classList.add('active')

      else
        likeEl.classList.remove('active')
        unlikeEl.classList.remove('active')

  ###
   * @param {Event} event
  ###
  preventDefault:( event )-> event.preventDefault()

  ###
   * @param {Event} event
  ###
  onLike:( event )->
    #@setStatus( @getStatus() == @LIKE ? '' : @LIKE )
    @setStatus @LIKE
    @renderByData()
    console.log( arguments )

  ###
   * @param {Event} event
  ###
  onUnLike:( event )->
    #@setStatus( @getStatus() == @UNLIKE ? '' : @UNLIKE )
    @setStatus( @UNLIKE )
    @renderByData()
    console.log( arguments )

  ###
   * @return HTMLElement
  ###
  buildElement:()->

    (domUtils.createElementByHTML """
      <div class="eh-score-view">
        <div class="eh-like eh-circle-button" eh-event-click="onLike()" eh-event-mousedown="preventDefault()">
          <img src="#{pathBuilder.img( "satisfaction_like.png" )}" />
          <img class="active" src="#{pathBuilder.img( "satisfaction_like_active.png" )}" />
	    </div>
	    <div class="eh-unlike eh-circle-button" eh-event-click="onUnLike()" eh-event-mousedown="preventDefault()">
          <img src="#{pathBuilder.img( "satisfaction_unlike.png" )}" />
          <img class="active" src="#{pathBuilder.img( "satisfaction_unlike_active.png" )}" />
	    </div>
      </div>
    """)[0]


