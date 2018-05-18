# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $('#start_date').fdatepicker
    format: 'dd-mm-yyyy'
    disableDblClickSelection: true
    leftArrow: '<<'
    rightArrow: '>>'
    closeIcon: 'X'
    language: 'ru'