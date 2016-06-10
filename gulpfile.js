var gulp = require('gulp');
var sass = require('gulp-sass');

gulp.task('default', ['sass:watch']);

gulp.task('sass', function () {
  return gulp.src('./media/sass/styles.scss')
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('./media/css'));
});

gulp.task('sass:watch', function () {
  gulp.watch('./public/sass/**/*.scss', ['sass', 'inject']);
});

// \Big[\frac{\hbar^2}{2m}\frac{\partial^2}{\partial x^2} + V\Big]\Psi = i\hbar \frac{\partial}{\partial t} \Psi

gulp.task('inject', function(){
    var wiredep = require('wiredep').stream;
    var inject = require('gulp-inject');

    var injectSrc = gulp.src([
      './static/js/**/*.js',
      './static/css/**/*.css',
      './static/orbit/css/styles.css',
    ], {read: false});

    var injectOptions = {
        ignorePath: '/'
    };

    var options = {
        bowerJson: require('./bower.json'),
        directory: './static/lib',
        ignorePath: '..'
    };

    return gulp.src('./templates/index.html')
        .pipe(wiredep(options))
        .pipe(inject(injectSrc, injectOptions))
        .pipe(gulp.dest('./templates'));

});
