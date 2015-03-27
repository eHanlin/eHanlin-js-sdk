
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
    @commentView.setTextAreaPlaceHolder '請留下您對此影片的意見或心得想法，以協助我們製作出更符合您學習需求的教學影片'
    @onLoadData()
    @registerEvent()
    @commentWindowWidth = 500
    domUtils.css @commentWindowView.el, {position:'absolute', width:"#{@commentWindowWidth}px", display:'none',zIndex:1}
    document.addEventListener 'click', => @closeComment()
    
  ###
   *
  ###
  onLoadData:()->
    @data_ = {}
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
      if !(typeof respData.like is 'undefined') then @data_ = like:respData.like else @data_ = {}
      @syncAttrToData()
      @renderByData()

  ###
   *
  ###
  syncAttrToData:-> util.clone @data_, util.getDataByDatasetKey( @el, "ehAttr" )

  ###
   * @param {String} like
  ###
  setLike:( like )->
    @data_.like = like
    @putToServer()
    @fireEvent 'likeChange', @data_

  ###
   *
  ###
  putToServer:->
    {ehAttrUser, ehAttrType, ehAttrTarget} = @el.dataset
    @syncAttrToData()
    api.putComment ehAttrUser, ehAttrType, ehAttrTarget, @data_
    

  ###
   * @type String
  ###
  getLike:()->
    @data_.like

  LIKE:1,
  UNLIKE:0,

  ###
   *
  ###
  renderByData:()->
    like = @data_.like
    el = @el
    likeEl = el.querySelector('.eh-like')
    unlikeEl = el.querySelector('.eh-unlike')

    switch like
      when 1
        likeEl.classList.add('active')
        unlikeEl.classList.remove('active')

      when 0
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
    @setLike @LIKE
    @renderByData()
    @showComment event.originalElement

  ###
   * @param {Event} event
  ###
  onUnLike:( event )->
    #@setStatus( @getStatus() == @UNLIKE ? '' : @UNLIKE )
    @setLike( @UNLIKE )
    @renderByData()
    @showComment event.originalElement

  ###
   * @param {Event} event
  ###
  onCommentSubmit:( event )->
    detail = event.detail
    @data_["suggestion"] = detail.text
    if @enabledSection
      @data_["section"] = detail.select
      if @data_["section"] is ''
        notification.message "請選擇段落","eHanlin"
        return

    @closeComment()
    @putToServer()
    notification.message "我們已經收到你的意見，感謝您！祝您學習愉快！","eHanlin"

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


