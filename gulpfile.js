
var gulp = require('gulp'),
plugins = require('gulp-load-plugins')(),
pack = require('./package.json'),
port = 9191;

var buildConactScript = function( scripts, output ){
  return gulp.src(scripts)
             .pipe(plugins.concat(output))
             .pipe(plugins.uglify())
             .pipe(plugins.header('//verion: <%= version %>\n',{version:pack.version}));
}; 

gulp.task('less', function () {
  gulp.src('./src/**/*.less')
  .pipe(plugins.less())
  .pipe(gulp.dest('.tmp'));
});

gulp.task('server', ["less","watch"], function () {

  plugins.connect.server({
   root: ['bower_components', '.tmp', 'src', 'demo'],
   port: port,
     livereload: true
  });

  plugins.bower()
  .on('end',function(){
    require('opn')('http://localhost:' + port + '/')
  });

});

gulp.task('build', function(){

  buildConactScript([ 
      'src/js/eHanlinSDK.prefix',
      'src/js/config.js',
      'src/js/util.js',
      'src/js/domUtils.js',
      'src/js/pathBuilder.js',
      'src/js/EventBinder.js',
      'src/js/Model.js',
      'src/js/View.js',
      'src/js/ScoreView.js',
      'src/js/XEHML.js',
      'src/js/eHanlinSDK.suffix'
  ], 'js/sdk.js')
    .pipe(gulp.dest( pack.dist )); 

  gulp.src('./src/**/*.less')
  .pipe(plugins.less())
  .pipe(gulp.dest( pack.dist ));
});

gulp.task('watch',function(){
  gulp.watch('./src/*.less', ['less']);
});

gulp.task('default', ['build']);

