// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

    $('#table_invoice').click( function () {
            $('#read').disabled = false;
        });
$(document).ready( function () {

    // document.querySelector("span").addEventListener("click", function () {
    //     document.querySelector("#read").disabled = false;
    // });
    // document.querySelector("#close_modal").addEventListener("click", function () {
    //     document.querySelector("#read").disabled = false;
    // });

    $('#table_invoice').DataTable({
        responsive: true,
        'aoColumnDefs': [
            {
                'bSortable': false,
                'aTargets': [5, 6, 7]
            }
        ],
        'language': {
            'lengthMenu': 'Количество строк _MENU_',
            'search': 'Поиск:',
            'info': 'Страница _PAGE_ из _PAGES_',
            'paginate': {
                'first': 'Первый',
                'last': 'Последний',
                'next': 'Туда',
                'previous': 'Сюда'
            }
        }
    });
} );