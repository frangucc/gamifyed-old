gulp = require("gulp")
gutil = require("gulp-util")
concat = require("gulp-concat")
sass = require("gulp-ruby-sass")
minifyCss = require("gulp-minify-css")
rename = require("gulp-rename")
coffee = require("gulp-coffee")
sourcemaps = require("gulp-sourcemaps")
jade = require("gulp-jade")

paths =
  sass:
    source: ["styles/**/*.sass"]
    dest: './www/css'
  coffee:
    source: ["scripts/**/*.coffee"]
    dest: './www/js'
  templates:
    source: ["views/**/*.jade"]
    dest: './www'

gulp.task "default", ["sass", "coffee", "templates"]

gulp.task "templates", ->
  YOUR_LOCALS = {}

  gulp.src(paths.templates.source)
      .pipe(jade(locals: YOUR_LOCALS))
      .pipe(gulp.dest(paths.templates.dest))

gulp.task "coffee", (done) ->
  gulp.src(paths.coffee.source)
      .pipe(sourcemaps.init())
      .pipe(coffee(bare: true).on("error", gutil.log))
      .pipe(concat("application.js"))
      .pipe(sourcemaps.write())
      .pipe(gulp.dest(paths.coffee.dest))

gulp.task "sass", (done) ->
  gulp.src(paths.sass.source)
      .pipe(sass())
      .pipe(gulp.dest(paths.sass.dest))
      .pipe(minifyCss(keepSpecialComments: 0))
      .pipe(rename(extname: ".min.css"))
      .pipe(gulp.dest(paths.sass.dest))

gulp.task "watch", ->
  gulp.watch paths.sass.source, ->
    gulp.start("sass")
  gulp.watch paths.coffee.source, ->
    gulp.start("coffee")
  gulp.watch paths.templates.source, ->
    gulp.start("templates")

gulp.task 'install', ['git-check'], ->
  bower.commands.install()
    .on 'log', (data) ->
      gutil.log('bower', gutil.colors.cyan(data.id), data.message)

gulp.task 'git-check', (done) ->
  if !sh.which('git')
    console.log(
      '  ' + gutil.colors.red('Git is not installed.'),
      '\n  Git, the version control system, is required to download Ionic.',
      '\n  Download git here:', gutil.colors.cyan('http://git-scm.com/downloads') + '.',
      '\n  Once git is installed, run \'' + gutil.colors.cyan('gulp install') + '\' again.'
    )
    process.exit(1)
  done()
