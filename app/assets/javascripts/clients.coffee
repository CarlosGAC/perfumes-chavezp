# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $("input[data-autocomplete]").each ->
    url = $(this).data('autocomplete')
    $(this).autocomplete
      source: url
      select: (event, ui)->
        $('#ciudad').val(ui.item.township)
        $('#colonia').val(ui.item.settlement)
        $('#estado').val(ui.item.state)