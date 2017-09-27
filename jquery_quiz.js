// # Clicking on the "remove" link on each row/line removes the entire row
// # ● Clicking on the "remove selected" link, removes the selected lines
// # ● If you click on the checkbox inside the header of the table it selects/deselects all rows
// # ● When you click on the checkbox of each row, if all lines are selected then the
// # checkbox on the table header must also become selected.

// JSFiddle for this: https://jsfiddle.net/so45m0to/

// I have basically zero experience with Jquery. I've played around with it, but never indepth. The below
// results are probably pretty hacky, but they work on my jsfiddle. (https://jsfiddle.net/so45m0to/)
// I did just sign up for a 40-hour Javascript course on Udemy last week though.


$("tbody .remove-action").click(function(){
   $(this).closest('tr').remove();
});

$("thead .selection").click(function(){
  $('input:checkbox').prop('checked', this.checked);    
});

$("thead .remove-action").click(function(){
  $('tbody input:checkbox:checked').closest('tr').remove();  
});

$("tbody input:checkbox").change(function(){
 var checked = $("tbody input:checkbox:checked").size();
 var total = $("tbody input:checkbox").size();
 if (checked == total){
  $('thead input:checkbox').prop('checked', this.checked);
 }
});