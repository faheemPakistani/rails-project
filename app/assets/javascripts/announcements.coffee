# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.querySelectorAll('.reply-btn').forEach (el) ->
  el.addEventListener 'click', (ev) ->
    ev.preventDefault()
    el.nextElementSibling.style = 'display: block;'
    return
  return


document.querySelectorAll('.view-btn').forEach (el) ->
  el.addEventListener 'click', (ev) ->
    ev.preventDefault()
    el.nextElementSibling.style = 'display: block;'
    return
  return
