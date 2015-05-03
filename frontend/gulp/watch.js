'use strict';

var gulp = require('gulp');

var paths = gulp.paths;

gulp.task('watch', ['markups', 'inject'], function () {
  gulp.watch([
    paths.src + '/*.html',
    paths.src + '/{app,components}/**/*.scss',
    paths.src + '/{app,components}/**/*.js',
    paths.src + '/{app,components}/**/*.coffee',
    'bower.json'
  ], ['inject']);
  gulp.watch(paths.src + '/{app,components}/**/*.haml', ['markups']);
});
