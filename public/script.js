$(document).ready(function() {
  
  setInterval(function() {
    
    $.get("messages", {}, function(data) {
      $("#messages").html(data);
    });
    
  }, 10000);
  
});


