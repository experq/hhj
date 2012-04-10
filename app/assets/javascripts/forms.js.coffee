
initRadioButtons = (delegateFor) ->
  delegateFor.delegate ".status-buttons .radio input,.buttons .radio input", "click", () ->
    $(this).parents('.status-buttons,.buttons').first().find('.btn').removeClass('checked')
    $(this).parents('.btn:first').addClass('checked')

uniformify = (node) ->
  $("select, input:checkbox, input:radio, input:file, input:text, textarea, submit", node).uniform()

window.initDom = (selector) ->
  node = $(selector)
  uniformify node
  initRadioButtons node
  return node

