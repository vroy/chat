$(document).ready(function() {
  $("#message").focus();
  
  $("#send").click(function() {
    reload($("#message").val());
    $("#message").val("");
  });
  
  function reload(msg) {
    var msgs = $("#msgs_frame").contents().find("#messages");
    
    var last = $("#last");
    
    $.getJSON("/messages",
      { 'last': last.val(), 'message': msg },
      
      function(data) {
        last.val(data["last"]);
        msgs.append(data["msgs"]);
      }
    );
  }
  
  setTimeout(function() {
    reload("");
  }, 200);
  
  setInterval(function() {
    reload("");
  }, 2000);
});

