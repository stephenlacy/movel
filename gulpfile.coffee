gulp = require 'gulp'

source     = require 'vinyl-source-stream'
buffer     = require 'vinyl-buffer'
coffeeify  = require 'coffeeify'
browserify   = require 'browserify'

jade = require 'gulp-jade'
csso = require 'gulp-csso'
cache = require 'gulp-cached'
coffee = require 'gulp-coffee'
stylus = require 'gulp-stylus'
uglify = require 'gulp-uglify'
concat = require 'gulp-concat'
plumber = require 'gulp-plumber'
reload = require 'gulp-livereload'
htmlmin = require 'gulp-minify-html'

gutil = require 'gulp-util'
gif = require 'gulp-if'
sourcemaps = require 'gulp-sourcemaps'


nib = require 'nib'
autoprefixer = require 'autoprefixer-stylus'
autowatch = require 'gulp-autowatch'


# paths
paths =
  vendor: './client/vendor/**/*'
  img: './client/img/**/*'
  fonts: './client/fonts/**/*'
  coffee: './client/**/*.coffee'
  coffeeSrc: './client/start.coffee'
  stylus: './client/**/*.styl'
  jade: './client/**/*.jade'

gulp.task 'server', (cb) ->
  require './start'

# javascript
gulp.task 'coffee', ->
  bCache = {}
  b = browserify paths.coffeeSrc,
    debug: true
    insertGlobals: true
    cache: bCache
    extensions: ['.coffee']
  b.transform coffeeify
  b.bundle()
  .pipe source 'start.js'
  .pipe buffer()
  .pipe plumber()
  .pipe gif gutil.env.production, uglify()
  .pipe gulp.dest './public'
  .pipe reload()

# styles
gulp.task 'stylus', ->
  gulp.src paths.stylus
    .pipe sourcemaps.init()
    .pipe stylus
      use:[
        nib()
        autoprefixer cascade: true
      ]
      sourcemap:
        inline: true
    .pipe concat 'app.css'
    .pipe sourcemaps.write()
    .pipe gif gutil.env.production, csso()
    .pipe gulp.dest './public'
    .pipe reload()

gulp.task 'jade', ->
  gulp.src paths.jade
    .pipe jade()
    .pipe cache 'html'
    .pipe gif gutil.env.production, htmlmin()
    .pipe gulp.dest './public'
    .pipe reload()

gulp.task 'vendor', ->
  gulp.src paths.vendor
    .pipe cache 'vendor'
    .pipe gulp.dest './public/vendor'
    .pipe reload()

gulp.task 'img', ->
  gulp.src paths.img
    .pipe cache 'img'
    .pipe gulp.dest './public/img'
    .pipe reload()

gulp.task 'fonts', ->
  gulp.src paths.fonts
    .pipe cache 'fonts'
    .pipe gulp.dest './public/fonts'
    .pipe reload()

gulp.task 'watch', ->
  autowatch gulp, paths


gulp.task 'css', ['stylus']
gulp.task 'js', ['coffee']
gulp.task 'static', ['jade', 'vendor', 'img', 'fonts']
gulp.task 'default', ['js', 'css', 'static', 'server', 'watch']
