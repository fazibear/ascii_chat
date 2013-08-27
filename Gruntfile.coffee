module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      dist:
        options:
          join: true
        files:
          'public/application.js': ['client/webcam.coffee', 'client/asciify.coffee', 'client/application.coffee']
     watch:
       coffee:
         files: ['client/*.coffee']
         tasks: ['coffee']
         options:
           spawn: false

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  
  grunt.registerTask "default", ["coffee"]
