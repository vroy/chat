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
  
  function reload(msg) {
    var room = $("#room").val();
    
    $.getJSON("/messages", {'room':room}, function(data) {
      $("#messages").html(data["msgs"]);
    });
  }
  
  function reload_users() {
    var room = $("#room").val();
    
    $.getJSON("/users", {'room': room}, function(data) {
      $("#logged_in").html(data["users"]);
    });
  }
  
  $(window).load(function() {
    setTimeout(function() {
      reload();
      reload_users();
      $("#msgs_frame").scrollTo($("#end"));
    }, 200);
  });
  
  setInterval(function() {
    reload();
  }, 5000);
  
  setInterval(function() {
    reload_users();
  }, 5000);
  
});

