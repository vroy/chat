$(document).ready(function() {
  $("#message").focus();
  
  $("#send").click(function() {
    var msg = $("#message").val();
    var room = $("#room").val();
    
    $.getJSON("/message", {'msg': msg, 'room': room }, function(data) {
      reload();
      $("#message").val("");
    });
    
  });
  
  function reload(msg) {
    var room = $("#room").val();
    
    var msgs = $("#msgs_frame").contents().find("#messages");
    
    $.getJSON("/messages", {'room':room}, function(data) {
      msgs.html(data["msgs"]);
    });
  }
  
  setTimeout(function() {
    reload();
  }, 200);
  
  setInterval(function() {
    reload();
  }, 2000);
  
});

