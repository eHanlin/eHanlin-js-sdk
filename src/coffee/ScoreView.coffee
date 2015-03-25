
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

    @commentWindowView = @findViewByName 'commentWindow'
    @commentView = @findViewByName 'comment'
    @onLoadData()
    @registerEvent()
    @commentWindowWidth = 500
    domUtils.css @commentWindowView.el, {position:'absolute', width:"#{@commentWindowWidth}px", display:'none'}
    document.addEventListener 'click', => @closeComment()
    
  ###
   *
  ###
  onLoadData:()->
    @data_ =
      status:''
    dataset = @el.dataset
    {ehAttrUser, ehAttrType, ehAttrTarget} = dataset
    deferred = api.getComment ehAttrUser, ehAttrType, ehAttrTarget, 1

    selects = JSON.parse( dataset.ehCommentSelect or "[]" )

    if selects.length
      @commentView.renderSelect selects
      @enabledSection = true
    else
      @commentView.hideSelector()

    deferred.done ( resp )=>
      respData = if resp and resp.result and resp.result.length then resp.result[0] else {}
      if respData.status then @data_ = status:respData.status else @data_ = {}
      util.clone @data_, util.getDataByDatasetKey( @el, "ehAttr" )
      @renderByData()

  ###
   * @param {String} status
  ###
  setStatus:( status )->
    @data_.status = status
    @putToServer()
    @fireEvent 'statusChange', @data_

  ###
   *
  ###
  putToServer:->
    {ehAttrUser, ehAttrType, ehAttrTarget} = @el.dataset
    api.putComment ehAttrUser, ehAttrType, ehAttrTarget, @data_
    

  ###
   * @type String
  ###
  getStatus:()->
    @data_.status

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
    @showComment event.originalElement

  ###
   * @param {Event} event
  ###
  onUnLike:( event )->
    #@setStatus( @getStatus() == @UNLIKE ? '' : @UNLIKE )
    @setStatus( @UNLIKE )
    @renderByData()
    @showComment event.originalElement

  ###
   * @param {Event} event
  ###
  onCommentSubmit:( event )->
    detail = event.detail
    @data_["suggestion"] = detail.text
    if @enabledSection then @data_["section"] = detail.select
    @closeComment()
    @putToServer()

  ###
   *
  ###
  showComment:( el )->
    height = el.clientHeight
    elOffset = domUtils.offset @el
    left = document.body.clientWidth - elOffset.left - @commentWindowWidth
    offset =
      left:if left > 0 then el.offsetLeft + 5 else el.offsetLeft + el.clientWidth - @commentWindowWidth - 5
      top:el.offsetTop + 10

    domUtils.css @commentWindowView.el, {display:'block', left:"#{offset.left}px" , top:"#{offset.top + height}px"}

  ###
  *
  ###
  closeComment:-> domUtils.css @commentWindowView.el, {display:'none'}

  ###
  #
  ###
  stopPropagation:( event )->  event.stopPropagation()

  ###
   * @return HTMLElement
  ###
  buildElement:()->

    (domUtils.createElementByHTML """
      <div class="eh-score-view" eh-event-click="stopPropagation()">
        <div class="eh-like eh-circle-button" eh-event-click="onLike()" eh-event-mousedown="preventDefault()">
          <div class="like-img eh-img-btn"></div>
          <div class="active eh-img-btn like-img-active"></div>
	    </div>
	    <div class="eh-unlike eh-circle-button" eh-event-click="onUnLike()" eh-event-mousedown="preventDefault()">
          <div class="unlike-img eh-img-btn"></div>
          <div class="active eh-img-btn unlike-img-active"></div>
	    </div>
        <div data-eh-action="commentWindow" eh-event-commentSubmit="onCommentSubmit()"></div>
      </div>
    """)[0]


