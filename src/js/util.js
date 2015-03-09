
/***
 * @namespace
 */
var util = {

  /**
   * @param {Object} obj
   * @type boolean
   */
  isObject:function( obj ){ return typeof obj == "object"; },

  /**
   * @param {Object} obj
   * @type boolean
   */
  isArray:function( obj ){ return Object.prototype.toString.call(obj) == "[object Array]"; },

  /**
   * @param {Object} obj
   * @type boolean
   */
  isArrayLike:function( obj ){

    var length = obj.length;

    if ( typeof obj === "function" ) return false;

    return this.isArray( obj ) ||
           length === 0 || ( typeof length === "number" && length > 0 && ( length - 1 ) in obj );
  },

  /**
   *
   *
   */
  each:function( obj, callback ){
    var value, i = 0;

    if ( this.isArrayLike( obj ) ) {

      for ( ; i < obj.length ; i++ ) {
        value = callback.call( obj[i], i, obj[i] );

        if ( value === false ) break;
      }

    } else {

      for ( i in obj ) {
        value = callback.call( obj[i], i, obj[i] );

        if ( value === false ) break;
      }
    }

  },

  /**
   * @param {Object} target
   * @param {Object} obj
   * @type Object
   */
  clone:function( deep, cloneObj, copyObj ){

    var target, obj;

    if ( typeof deep != "boolean" ) {
      target = deep,
      obj = cloneObj;
    } else {
      target = cloneObj;
      obj = copyObj;
    }

    for ( var i in obj ) {

      if ( util.isArray( obj[i] ) ) {

        target[i] = util.isArray( target[i] ) ? target[i]: [];

      } else if ( util.isObject( obj[i] ) ) {

        target[i] = util.isObject( target[i] ) ? target[i]: {};

      }

      if ( deep && util.isObject( obj[i] ) ) this.clone( target[i], obj[i] );

      else target[i] = obj[i];
    }

    return target;
  },

  /***
   * @param {Array} array
   * @type Array
   */
  copyArray:function( array ){

    var newArray = [];

    for ( var i = 0; i<array.length; i++ ) newArray[i] = array[i];
    return newArray;
  },

  /**
   * @param {function} constructor
   * @param {function} superConstructor
   */
  inherits:function( constructor, superConstructor ){

    this.clone( true, constructor.prototype, superConstructor.prototype );
  }
};



