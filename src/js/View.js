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
  }
  
});

