# Namespacing support
# https://github.com/jashkenas/coffee-script/wiki/FAQ#unsupported-features
namespace = (target, name, block) ->
  [target, name, block] =
    [(if typeof exports isnt 'undefined' then exports else window),
    arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

# App scripts
namespace "App", (exports) ->

  # Example function
  exports.hello = (subject = "world") ->
    console.log "Hello, " + subject + "."
    console.log($('header').text())
    return

  # exports.smoothState = () ->
  # options = 
  #   debug: false
  #   scroll: false
  #   anchors: '[href]'
  #   # loadingClass: 'is-loading'
  #   prefetch: true
  #   cacheLength: 4
  #   onBefore: (request, $container) ->
  #     # popstate = request.url.replace(/\/$/, '').replace(window.location.origin + $root, '');
  #     # console.log(popstate);
  #     return
  #   onStart:
  #     duration: 0
  #     render: ($container) ->
  #       $("body").addClass 'is-loading'
  #       return
  #   onReady:
  #     duration: 0
  #     render: ($container, $newContent) ->
  #       # Inject the new content
  #       $(window).scrollTop 0
  #       # $body.attr 'page-type', $newContent.find('#page-content').attr('page-type')
  #       $container.html $newContent
  #       # app.interact()
  #       return
  #   onAfter: ($container, $newContent) ->
  #     $("body").removeClass 'is-loading'
  #     # setTimeout(function() {
  #     # Clear cache for random content
  #     # smoothState.clear();
  #     # }, 200);
  #     return
  # smoothState = $("#container").smoothState(options).data('smoothState')
  # return

  # Initialization scripts
  (exports.init = ->
    # App.smoothState

    return
  )()

  return
