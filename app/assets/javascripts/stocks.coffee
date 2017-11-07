# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", ->
  $('#table_stock').dataTable
    responsive: true
    'aoColumnDefs': [ {
        'bSortable': false
        'aTargets': [ 4, 5, 6 ]
    } ]
    'language':
        'lengthMenu': 'Количество строк _MENU_'
        'search': 'Поиск:'
        'info': 'Страница _PAGE_ из _PAGES_'
        'paginate':
            'first': 'Первый'
            'last': 'Последний'
            'next': 'Туда'
            'previous': 'Сюда'