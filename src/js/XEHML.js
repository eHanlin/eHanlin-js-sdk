/**
 * @namespace
 */
var viewBuilder = {
  score:ScoreView
};

/**
 * @namespace
 */
EH.XEHML = {

  /***
   * <div data-eh-action="score" ></div>
   * @param {HTMLElement} dom
   * @param {Function} cb
   */
  parse:function( dom, cb ){

    var el = dom, callback = cb;

    if ( !domUtils.isElement( dom ) ) {

      el = document.body;
      callback = dom;
    }
    
    var buildElems = el.querySelectorAll( '[data-eh-action]' );

    if ( el.dataset.ehAction ) {

    }

    for ( var index = 0; index < buildElems.length; index++ ) {

      var buildEl = buildElems[index];
      //elementBuilder[buildEl.dataset.ehAction]( buildEl );
      var view = new viewBuilder[buildEl.dataset.ehAction];
      view.onCreate( buildEl );
    }
  }
};


EH.XEHML.parse();

