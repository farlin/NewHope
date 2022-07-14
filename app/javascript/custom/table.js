// import $ from 'jquery'; // for accessing jQuery from every pack
import "https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js";
import "https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js";


// $(document).ready(function() {
// $(document).on('turbolinks:load', function() {
$(document).on('turbo:load', function() {
	$('#dataTable').DataTable(
    	{
			language : {
				sLengthMenu: "Show _MENU_"
			}
    	});

});