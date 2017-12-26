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
  exports.interact = () ->
    App.infiniteScrollEvents()
    $('body.with-intro').click (e)->
      $("body").addClass("animate")
      setTimeout ->
        $("body").removeClass 'with-intro animate'
        $("#intro").remove()
      , 700
    $('[event-target=menu]').click (e)->
      $("body").toggleClass("menu-visible")
    $('[data-image]').on 'mouseenter', (e) =>
      $(".featured-image").append("<img class='lazy lazyload' data-src='"+e.target.getAttribute("data-image")+"'>")
    $('[data-image]').on 'mouseleave', (e) =>
      $(".featured-image")[0].innerHTML = ""
    return

  exports.infiniteScrollEvents = () ->
    events = document.querySelector("#events")
    if events
      nextURL = document.querySelector(".next-month").getAttribute("href")
      infScroll = new InfiniteScroll(events,
      path: () =>
        return nextURL
      append: ".month"
      checkLastPage: true
      prefill: true
      responseType: 'document'
      outlayer: false
      scrollThreshold: 200
      elementScroll: "#container"
      loadOnScroll: true
      history: undefined
      historyTitle: true
      hideNav: "#event-pagination"
      status: '.page-load-status'
      button: undefined
      onInit: undefined
      debug: false)
      infScroll.on 'load', (response, path) ->
        nextURL = response.querySelector(".next-month").getAttribute("href")
    return

  exports.smoothState = () ->
    options = 
      debug: false
      scroll: false
      anchors: '[href]:not([data-target=artist])'
      loadingClass: false
      prefetch: false
      cacheLength: 4
      onBefore: (request, $container) ->
        # popstate = request.url.replace(/\/$/, '').replace(window.location.origin + $root, '');
        # console.log(popstate);
        return
      onStart:
        duration: 400
        render: ($container) ->
          $("body").addClass 'is-loading'
          return
      onReady:
        duration: 400
        render: ($container, $newContent) ->
          # Inject the new content
          $(window).scrollTop 0
          # $("body").attr 'page-type', $newContent.find('#container').attr 'page-type'
          $container.html $newContent
          App.interact()
          return
      onAfter: ($container, $newContent) ->
        $("body").removeClass 'is-loading'
        setTimeout ->
          $("body").removeClass 'menu-visible'
        , 400
        # Clear cache for random content
        # smoothState.clear();
        return
    smoothState = $("#wrapper").smoothState(options).data('smoothState')
    return

  # Initialization scripts
  (exports.init = ->
    window.viewportUnitsBuggyfill.init()
    $(document).ready () ->
      App.smoothState()
      App.interact()

    return
  )()

  return
