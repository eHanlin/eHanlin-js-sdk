
/**
 * @class
 */
var Model = function(){this.data = {}};

util.clone( Model.prototype, {
  /**
   * @param {String} name 
   * @param {*} val 
   */
  set:function( name, val ){

    if ( arguments.length == 1 && util.isObject( name ) ) {
      util.clone( this.data, name );
    } else {
      this.data[name] = val;
    }
  },

  /**
   * @param {String} name 
   * @type *
   */
  get:function( name ){
    return this.data[name];
  }
});


