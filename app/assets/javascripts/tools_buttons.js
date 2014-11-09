function hide_search_results(){
	$('.search_field').prop('hidden',true);
	$('#search_tab').prop('hidden', true);
	$('a.all').trigger('click');
}

$(document).ready( function(){
	$('.tools-edit').click(function(){
		var chbx = $('.active input[id^="chbx_"]').filter(':checked')
		var path = 'prod_returns/'+15+'/edit'
		var id = chbx.prop("id");
		id = id.replace('chbx_','');
		$('.tools').prop('hidden', true);
		hide_search_results();
		$.post('/prod_returns/show_edit',{id: id});
	});
});

$(document).ready( function(){
	$('.tools-delete').click(function(){
		var ids = [];
		var chbx = $('.active input[id^="chbx_"]').filter(':checked');
		chbx.each( function(index) {
			ids.push($(this).prop("id"));
		});
		$('.tools').prop('hidden', true);
		hide_search_results();
		$.post('/prod_returns/group_delete',{id:ids});
	});
});

$(document).ready( function() {
	$('#tools_delete_att').click( function(){
		var ids = [];
		var chbx = $('.active input[id^="chbx_"]').filter(':checked');
		chbx.each( function(index) {
			ids.push($(this).prop("id"));
		});
		$('.tools').prop('hidden', true);
		hide_search_results();
		$.post('/prod_returns/group_delete_att',{id:ids});
	});
});

$(document).ready(function(){
	$('#tools_search').click( function(){
		if ($('.search_field').prop('hidden')==true) {
			$('.tools').prop('hidden', true);
			$('.search_field').prop('hidden',false);
		}else {
			$('#search_form').submit();
		}

	});
});
