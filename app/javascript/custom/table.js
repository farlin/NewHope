// import $ from 'jquery'; // for accessing jQuery from every pack
import "https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js";
import "https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js";


$(document).on('turbo:load', function() {
  "use strict";

  if ($("#dataTable_wrapper").length == 0) {
	$('#dataTable').DataTable(
    	{
			language : {
				sLengthMenu: "Show _MENU_"
			}
    	}
    );	
  }
});