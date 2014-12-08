
var prod_search = (function(){
	$('#products_autocomplete').autocomplete({
		minLength: 2,
		source: '/products/autocomplete.json',
		// Once a value in the drop down list is selected, do the following:
		select: function(event, ui) {
	 		// place the person.given_name value into the textfield called 'select_origin'...
			$('#products_autocomplete').val(ui.item.name);
			// and place the person.id into the hidden textfield called 'link_origin_id'. 
			$('#product_id').val(ui.item.id);
			return false;
		}
	});
});

$(document).ready( prod_search );
$(document).on('page:load', prod_search);
