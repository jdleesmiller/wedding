// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function () {
  var radioMatcher = '#guest-edit-form input[name="guest[attending]"]'
  var radioButtons = $(radioMatcher)
  function toggleAttendingOnly () {
    var attending = $(radioMatcher + ':checked').val()
    $('.guest-attending-only textarea').attr('disabled', attending !== 'true')
  }
  radioButtons.on('change', toggleAttendingOnly)
  toggleAttendingOnly()
})
