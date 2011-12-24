// jquery ui elements
$(document).ready(function(){

  // all date pickers in the admin
  $(".datepicker").datepicker({
    dateFormat:'yy-mm-dd', 
    ampm: true,
    changeMonth: true,
    changeYear: true
  });

  // all time pickers in the admin
  $(".timepicker").timepicker({
    ampm: true,
  });

  // all date and time pickers in the admin
  $(".datetimepicker").datetimepicker({
    dateFormat:'yy-mm-dd', 
    ampm: true,
    changeMonth: true,
    changeYear: true
  });

});


