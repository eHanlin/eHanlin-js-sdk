/***
 * @class
 */
var View = function(){};

util.clone( View.prototype , {

  /**
   * @param {HTMLElement} el
   */
  onCreate:function( el ){

    var dom = this.buildElement();

    if ( el ) {

      this.el = el;
      this.el.appendChild( dom );

    } else {

      this.el = dom;
    }

    this.eventBinder = new EventBinder();
    XEHML.parse( this.el );
    this.registerEvent();
  },

  /**
   *
   */
  destroy:function(){

  },

  /**
   * @type HTMLElement
   */
  buildElement:function(){

    return domUtils.createElementByHTML('<div></div>')[0];
  },

  /**
   *
   */
  registerEvent:function(){

    var el = this.el;
    this.eventBinder.register( el, this );
  },

  /**
   * @param {String} name
   * @param {*} detail
   */
  fireEvent:function( name, detail ){

    domUtils.fireEvent( this.el, name, detail );
  },

  /**
   * @param {String} viewName
   * @type View
   */
  findViewByName:function( viewName ){
    var viewEl = this.el.querySelector( '[data-eh-action="' + viewName + '"]' );
    return util.data( viewEl, 'view' );
  }
  
});

