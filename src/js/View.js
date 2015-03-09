/***
 * @class
 */
var View = function(){};

util.clone( View.prototype , {

  /**
   * @param {HTMLElement} el
   */
  onCreate:function( el ){

    this.el = el;
    this.eventBinder = new EventBinder();
  },

  /**
   *
   */
  destroy:function(){

  },

  /**
   *
   */
  registerEvent:function(){

    var el = this.el;
    this.eventBinder.register( el, this );
  }
  
});

