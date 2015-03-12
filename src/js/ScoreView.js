
/**
 * @class
 * @extend View
 */
var ScoreView = function(){};

util.inherits( ScoreView, View );

util.clone( ScoreView.prototype, {

  /**
   * @Override
   * @param {HTMLElement} el
   *
   */
  onCreate:function( el ){

    View.prototype.onCreate.call( this, el );

    el.appendChild( this.buildElement() );
    this.onLoadData();
    this.registerEvent();
    
  },

  /**
   *
   */
  onLoadData:function(){
    this.data_ = {
      status:''
    };

    this.renderByData();
  },

  /**
   * @param {String} status
   */
  setStatus:function( status ){
    this.data_.status = status;
  },

  /**
   * @type String
   */
  getStatus:function(){
    return this.data_.status;
  },

  LIKE:'like',
  UNLIKE:'unlike',

  /**
   *
   */
  renderByData:function(){
    var status = this.data_.status;
    var el = this.el;
    var likeEl = el.querySelector('.eh-like');
    var unlikeEl = el.querySelector('.eh-unlike');

    switch ( status ) {
      case 'like':
        likeEl.classList.add('active');
        unlikeEl.classList.remove('active');
        break;

      case 'unlike':
        likeEl.classList.remove('active');
        unlikeEl.classList.add('active');
        break;

      default:
        likeEl.classList.remove('active');
        unlikeEl.classList.remove('active');
    }
  },

  /**
   * @param {Event} event
   */
  preventDefault:function( event ){

    event.preventDefault();
  },

  /**
   * @param {Event} event
   */
  onLike:function( event ){
    //this.setStatus( this.getStatus() == this.LIKE ? '' : this.LIKE );
    this.setStatus( this.LIKE );
    this.renderByData();
    console.log( arguments );
  },

  /**
   * @param {Event} event
   */
  onUnLike:function( event ){
    //this.setStatus( this.getStatus() == this.UNLIKE ? '' : this.UNLIKE );
    this.setStatus( this.UNLIKE );
    this.renderByData();
    console.log( arguments );
  },

  /**
   * @return HTMLElement
   */
  buildElement:function(){

    var container = domUtils.createElement( 'div' );

    container.innerHTML = [
      '<div class="eh-like eh-circle-button" eh-event-click="onLike()" eh-event-mousedown="preventDefault()">',
        '<img src="' + pathBuilder.img( "satisfaction_like.png" ) + '" />',
        '<img class="active" src="' + pathBuilder.img( "satisfaction_like_active.png" ) + '" />',
	  '</div>',
	  '<div class="eh-unlike eh-circle-button" eh-event-click="onUnLike()" eh-event-mousedown="preventDefault()">',
        '<img src="' + pathBuilder.img( "satisfaction_unlike.png" ) + '" />',
        '<img class="active" src="' + pathBuilder.img( "satisfaction_unlike_active.png" ) + '" />',
	  '</div>'
    ].join(' ');

    return container;
  }
});


