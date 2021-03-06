
var gulp = require('gulp'),
plugins = require('gulp-load-plugins')(),
pack = require('./package.json'),
port = 9191,
tmpFolder = '.tmp';

pack.dist = "dist";

var buildConactScript = function( scripts, output ){
  return gulp.src(scripts)
             .pipe(plugins.concat(output))
             .pipe(plugins.uglify({mangle:true, compress:true}))
             .pipe(plugins.header('//verion: <%= version %>\n',{version:pack.version}));
}; 

gulp.task('coffee', function() {
  gulp.src('./src/**/*.coffee')
  .pipe(plugins.coffee({bare: true}))
  .pipe(gulp.dest(tmpFolder))
});

gulp.task('less', function () {
  gulp.src('./src/**/*.less')
  .pipe(plugins.less())
  .pipe(gulp.dest(tmpFolder));
});

gulp.task('server', ["coffee", "less","watch"], function () {

  plugins.connect.server({
   root: ['bower_components', tmpFolder, 'src', 'demo'],
   port: port,
     livereload: true
  });

  plugins.bower()
  .on('end',function(){
    require('opn')('http://localhost:' + port + '/')
  });

});

gulp.task('build', ["less", "coffee"], function(){

  buildConactScript([ 
      'src/js/eHanlinSDK.prefix',
      tmpFolder + '/coffee/config.js',
      tmpFolder + '/coffee/util.js',
      tmpFolder + '/coffee/domUtils.js',
      tmpFolder + '/coffee/animationEffect.js',
      tmpFolder + '/coffee/queryString.js',
      'src/js/deferred.js',
      tmpFolder + '/coffee/ajax.js',
      tmpFolder + '/coffee/api.js',
      tmpFolder + '/coffee/Observer.js',
      'src/js/pathBuilder.js',
      'src/js/EventBinder.js',
      'src/js/Model.js',
      tmpFolder + '/coffee/View.js',
      tmpFolder + '/coffee/WindowView.js',
      tmpFolder + '/coffee/CommentView.js',
      tmpFolder + '/coffee/CommentWindowView.js',
      tmpFolder + '/coffee/NotificationWindowView.js',
      tmpFolder + '/coffee/notification.js',
      tmpFolder + '/coffee/ScoreView.js',
      'src/js/XEHML.js',
      'src/js/eHanlinSDK.suffix'
  ], 'js/sdk.js')
    .pipe(gulp.dest( pack.dist )); 

  gulp.src('./src/**/*.less')
  .pipe(plugins.less({compress:true}))
  .pipe(plugins.base64({
    baseDir: 'src',
    debug: true
  }))
  .pipe(gulp.dest( pack.dist ));

  gulp.src('./src/images/*')
      .pipe(gulp.dest( pack.dist + "/images" ));
});

gulp.task('watch',function(){
  gulp.watch('./src/**/*.coffee', ['coffee']);
  gulp.watch('./src/**/*.less', ['less']);
});

gulp.task('default', ['build']);

