$( document ).ready(function() {
	$('.check_all').click(function(){
		$('#check_action').prop("indeterminate", false);
		$('.active input[id^="chbx_"]').prop('checked', true);
		$('.tools').prop('hidden', false);
	});
});

$( document ).ready(function() {
	$('.check_none').click(function(){
		$('#check_action').prop("indeterminate", false);
		$('.active input[id^="chbx_"]').prop('checked', false);
		$('.tools').prop('hidden', true);
	});
});

$( document ).ready(function() {
	$('input[type="checkbox"]').click(function(){
		//$("#h01").html($('input[type="checkbox"]:checked').length);
		var chbx = $('.active input[id^="chbx_"]')
		var all_count = chbx.length
		var checked_count = chbx.filter(':checked').length
		if ( checked_count < all_count && checked_count > 0) {
			$('#check_action').prop("indeterminate", true);
		}
		if ( checked_count == all_count) {
			$('#check_action').prop("indeterminate", false);
			$('#check_action').prop("checked", 1);
		}else if ( checked_count == 0) {
			$('#check_action').prop("indeterminate", false);
			$('#check_action').prop("checked", false);
		}

		if (chbx.filter(':checked').length > 0) {
			$('.tools').prop('hidden', false);
			$('.tools-edit').prop('hidden', false);
			if (checked_count > 1 ){
				$('.tools-edit').prop('hidden', true);
			}
		}else {
			$('.tools').prop('hidden', true);
		}
		//$('#h01').html(chbx.filter(':checked').prop("id"))

	});
});

$(document).ready(function(event) {
    $('.table tr').click(function(event) {
        if ( $(event.target).is("td") ) {
            $(':checkbox', this).trigger('click');
        	if ( $(':checkbox', this).is(':checked') ) {
        		$(this).addClass('status_selected');
        	}else {
        		$(this).removeClass('status_selected');
        	}
        }
    });
});

