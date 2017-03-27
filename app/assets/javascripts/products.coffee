# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  trigger = $('.hamburger')
  overlay = $('.overlay')
  isClosed = false

  hamburger_cross = ->
    if isClosed == true
      overlay.hide()
      trigger.removeClass 'is-open'
      trigger.addClass 'is-closed'
      isClosed = false
    else
      overlay.show()
      trigger.removeClass 'is-closed'
      trigger.addClass 'is-open'
      isClosed = true
    return

  trigger.click ->
    hamburger_cross()
    return
  $('[data-toggle="offcanvas"]').click ->
    $('#wrapper').toggleClass 'toggled'
    return
  return
