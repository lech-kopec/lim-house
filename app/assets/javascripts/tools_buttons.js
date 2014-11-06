$(document).ready( function(){
	$('.tools-edit').click(function(){
		var chbx = $('.active input[id^="chbx_"]').filter(':checked')
		var path = 'prod_returns/'+15+'/edit'
		$.post('/prod_returns/show_edit',{id:chbx.prop("id")});
	});
});

$(document).ready( function(){
	$('.tools-delete').click(function(){
		var chbx = $('.active input[id^="chbx_"]').filter(':checked')
		$.post('/prod_returns/group_delete',{id:chbx.prop("id")});
	});
});

