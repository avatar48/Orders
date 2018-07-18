# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on 'click', 'tr[data-link]', (evt) -> 
    window.location = this.dataset.link


$(document).ready ->
  $('#table_partner tr:not(.first_tr)').hover (->
    $(this).addClass 'hover_color'
    return
  ), ->
    $(this).removeClass 'hover_color'
    return
  $('#table_partner tr:not(.first_tr)').click ->
    $(this).toggleClass 'click_color'
    return
  return
