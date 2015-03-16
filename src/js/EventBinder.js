
/**
 * @class
 */
var EventBinder = function(){};

util.clone( EventBinder.prototype, {

  EVENTS:['click', 'mousedown', 'mouseup', 'mousemove', 'touchstart', 'touchmove', 'touchend', 'load'],

  /**
   * @param {HTMLElement} el
   * @param {BasicView} view
   */
  register:function( el, view ){

    this.EVENTS.forEach(function( eventName ){
      var key = 'eh-event-' + eventName;
      util.each( el.querySelectorAll('[' + key + ']'), function( index, dom ){
        var values = /([^()].*)\((.*)\)/.exec( dom.getAttribute( key ) );
        var funcName = values[1];
        var params = eval('(function(){ return arguments;})(' + values[2] + ')');
        dom.addEventListener( eventName, function( event ){
          var eventParams = util.clone( [], params )
          eventParams.unshift( event );
          event.originalElement = dom;
          view[funcName].apply( view, eventParams );
        });
        //console.log( dom.getAttribute( key ) );
      });
    });
  }
});



