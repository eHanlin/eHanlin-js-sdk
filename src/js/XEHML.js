/**
 * @namespace
 */
var viewBuilder = {
  score:ScoreView,
  comment:CommentView,
  window:WindowView,
  commentWindow:CommentWindowView
};

/**
 * @namespace
 */
var XEHML = EH.XEHML = {

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

    util.each( buildElems, function( index, buildEl ) {

      //elementBuilder[buildEl.dataset.ehAction]( buildEl );
      if ( ! util.data( buildEl, 'view' ) ) {
        var children = util.copyArray( buildEl.children );
        var view = new viewBuilder[buildEl.dataset.ehAction];

        util.each( children, function(i, child){ child.remove(); });
        view.onCreate( buildEl );
        util.data( buildEl, 'view', view );

        var transcludeEl = buildEl.querySelector('[data-eh-transclude]');

        if ( transcludeEl ) {
          util.each( children, function(i , child){
            transcludeEl.appendChild( child );
          });
        }
      }
    });

  }
};


EH.XEHML.parse();

