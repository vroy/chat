$(document).ready(function() {
  $("#message").focus();
  
  $("#send").click(function() {
    var msg = $("#message").val();
    var room = $("#room").val();
    
    $("#message").val("");
    
    $.getJSON("/message", {'msg': msg, 'room': room }, function(data) {
      reload();
    });
    
    setTimeout(function() {
      $("#msgs_frame").scrollTo($("#end"));
    }, 400);
  });
  
  $("#quit").click(function() {
    $.post("/quit", {'room': $("#room").val()});
    location.href = "/";
  });
  
  function reload() {
    $.getJSON("/reload", {'room':$("#room").val()}, function(data) {
      $("#messages").html(data["msgs"]);
      
      $("#users").html(data["users"]);
    });
  }
  
  $(window).load(function() {
    setTimeout(function() {
      reload();
      setTimeout(function() {
        $("#msgs_frame").scrollTo($("#end"));
      }, 300);
    }, 300);
  });
  
  setInterval(function() {
    reload();
  }, 5000);
  
});

