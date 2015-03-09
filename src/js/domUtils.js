
/**
 * @namespace
 */
var domUtils = {

  /**
   * @param {String} queryStr
   * @type Array[]
   */
  query:function( queryStr ){

    document.querySelectorAll( queryStr );
  },

  /***
   * @param {HTMLElement}
   * @type boolean
   */
  isElement:function( obj ){

    try {
      //Using W3 DOM2 (works for FF, Opera and Chrom)
      return obj instanceof HTMLElement;
    }
    catch(e){
      //Browsers not supporting W3 DOM2 don't have HTMLElement and
      //an exception is thrown and we end up here. Testing some
      //properties that all elements have. (works on IE7)
      return (typeof obj==="object") &&
        (obj.nodeType===1) && (typeof obj.style === "object") &&
        (typeof obj.ownerDocument ==="object");
    }
  },

  /***
   * @param {String} tag
   * @type HTMLElement
   */
  createElement:function( tag ){

    return document.createElement( tag );
  }
};



