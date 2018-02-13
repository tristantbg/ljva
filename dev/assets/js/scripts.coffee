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
  exports.interact = (pagePanel) ->
    App.infiniteScrollEvents()
    App.scrollTitleChange()
    $('body').click (e)->
      if $(this).hasClass("with-intro")
        $("body").addClass("animate")
        setTimeout ->
          $("body").removeClass 'with-intro animate'
          $("#intro").remove()
        , 700
    $('[event-target=java-card-close], .java-card-close').click (e)->
      $("#java-card").removeClass("visible")
    if(!pagePanel)
      if $(window).width() > 1023
        $('[data-image]').on 'mouseenter', (e) =>
          $("#container #page-content .featured-image").append("<img class='lazy lazyload' data-src='"+e.target.getAttribute("data-image")+"'>")
        $('[data-image]').on 'mouseleave', (e) =>
          $("#container #page-content .featured-image")[0].innerHTML = ""
      $('[event-target=menu]').click (e)->
        $("body").toggleClass("menu-visible")
      $('#page-panel-close').click (e)->
        $("body").removeClass("page-panel")
        setTimeout ->
          $("#page-panel .inner").empty
        , 400
    return
  exports.scrollTitleChange = () ->
    events = document.querySelector("#events")
    $header = $("header")
    title = $header[0].querySelector("h2")
    $(window).scroll (e)->
      if events
        if $(events).offset().top - $(window).scrollTop() - $header.height() - 10 < 0
          title.innerHTML = title.getAttribute("data-scroll")
        else
          title.innerHTML = title.getAttribute("data-title")
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
      # elementScroll: "#container"
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
    target = null
    promoClick = 0
    options = 
      debug: false
      scroll: false
      anchors: '[href]:not([data-target=artist])'
      loadingClass: false
      prefetch: false
      cacheLength: 4
      onAction: ($currentTarget, $container) ->
        # popstate = request.url.replace(/\/$/, '').replace(window.location.origin + $root, '');
        target = $currentTarget.data("target")
        promoClick++
        # console.log(target)
        return
      onBefore: (request, $container) ->
        # popstate = request.url.replace(/\/$/, '').replace(window.location.origin + $root, '');
        # console.log(popstate);
        return
      onStart:
        duration: 400
        render: ($container) ->
          if target == "artiste"
            $("body").addClass 'page-panel'
          else
            $("body").removeClass 'page-panel'
          $("body").addClass 'is-loading'
          return
      onReady:
        duration: 400
        render: ($container, $newContent) ->
          # Inject the new content
          $(window).scrollTop 0
          # $("body").attr 'page-type', $newContent.find('#container').attr 'page-type'
          if target == "artiste"
            $("#page-panel .inner").html $newContent.find("#page-content")
            App.interact(true)
          else
            $container.html $newContent
            App.interact()
          return
      onAfter: ($container, $newContent) ->
        $("body").removeClass 'is-loading'
        target = null
        setTimeout ->
          $("body").removeClass 'menu-visible'
          if promoClick == 4
            $("#java-card").addClass("visible")
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
      if $(window).width() > 1023
        App.smoothState()
      App.interact()

    return
  )()

  return
