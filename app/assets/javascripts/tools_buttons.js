function hide_search_results(){
	$('.search_field').prop('hidden',true);
	$('#search_tab').prop('hidden', true);
	$('a.received').trigger('click');
};

$(document).ready( function(){
	$('#tools_show').click(function(){
		var chbx = $('.active input[id^="chbx_"]').filter(':checked')
		var id = chbx.prop("id");
		id = id.replace('chbx_','');
		$('.tools').prop('hidden', true);
		$.get('/prod_returns/'+id);
	});
});
$(document).ready( function(){
	$('#tools_edit').click(function(){
		var chbx = $('.active input[id^="chbx_"]').filter(':checked')
		var path = 'prod_returns/'+15+'/edit'
		var id = chbx.prop("id");
		id = id.replace('chbx_','');
		$('.tools').prop('hidden', true);
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
		console.log( "att" );
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

$(document).on('click','[id^="delete_att"]', function(){
	var id = $(this).prop('id');
	id = id.replace('delete_att','');
	$.post('/prod_returns/delete_att',{id:id});
});
$(document).on("mouseenter mouseleave",'.file', function(){
	$(this).find('[id^="delete_att"]').toggle();
});


$(document).ready(function(){
	$('#btn_backup').click(function(){
		$.post('/prod_returns/send_backup');
	});
});