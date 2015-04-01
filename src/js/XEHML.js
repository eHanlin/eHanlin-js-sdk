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

    if ( domUtils.getDataset( el ).ehAction && ! util.data( el, 'view' ) ) {
      this.renderElement_( [el] );
    }

    this.renderElement_( buildElems );

    if ( callback ) callback();

  },

  /**
   * @private
   * @param {HTMLElement[]} buildElems
   */
  renderElement_:function( buildElems ){

    util.each( buildElems, function( index, buildEl ) {

      if ( ! util.data( buildEl, 'view' ) ) {
        var children = util.copyArray( buildEl.children );
        var view = new viewBuilder[domUtils.getDataset( buildEl ).ehAction];

        util.each( children, function(i, child){
          //The IE 10 is not support remove
          var parentNode = child.parentNode;
          if ( parentNode ) parentNode.removeChild( child );
        });
        util.data( buildEl, 'view', view );
        view.onCreate( buildEl );

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

