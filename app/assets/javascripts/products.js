/*function hide_search_results(){
	$('.search_field').prop('hidden',true);
	$('#search_tab').prop('hidden', true);
	$('a.received').trigger('click');
};
*/
var euro2zl = 4.2;
var gross2net = 1.23;

function getId(elem){
	return elem.prop('id').replace(/\D/igm,'');
}

function calc_purchase_net_pl(){
	var pr_net_zl = $("[id^=pr_net_zl]");
	var id = '';
	var result = '';
	pr_net_zl.each( function(index){
		/*id = $(this).prop("id").replace('pr_net_zl','');*/
		id = getId($(this));
		/*id = getId($(this));*/
		id = 'pr_net_eur'+id;
		result = $("#"+id).prop('innerText').replace('€','');
		result = parseFloat(result) * euro2zl;
		$(this).html(''+result.toFixed(2));
	});
}

function calc_buy_now_net(){
	var buy_now_net = $("[id^=buy_now_net]");
	var id = '';
	var result = '';
	buy_now_net.each( function(){
		id = getId($(this));
		id = 'buy_now_gr'+id;
		result = $('#'+id).prop('innerText');
		result = parseFloat(result) / gross2net;
		$(this).html(''+result.toFixed(2));
	});
}

function cals_prod_plus_delivery(){
	var prod_plus_deliv = $("[id^=prod_plus_deliv]");
	var id = '';
	var result = '';
	var val1, val2 = 0;
	prod_plus_deliv.each(function(){
		id = getId($(this));
		val1 = $('#buy_now_gr'+id).prop('innerText');
		val2 = $('#delivery_cost'+id).prop('innerText');
		result = parseFloat(val1) + parseFloat(val2);
		$(this).html(result.toFixed(2));
	});
}
function calc_delivery_trim(){
	var deliv_trim = $("[id^=deliv_trim]");
	var id = '';
	var result = 0;
	deliv_trim.each(function(){
		id = getId($(this));
		result = parseFloat($('#delivery_cost'+id).prop('innerText')) - parseFloat($('#delivery_dhl_gr'+id).prop('innerText'));
		$(this).html(result.toFixed(2));
	});
}
/*
IF(
	F7<=100
		F7*0.06
	IF(F7<=1000
		(F7-100)*0.03+6,
	IF(F7<=5000,
		(F7-1000)*0.015+33,
		(F7-5000)*0.005+93)))
*/
function calc_provision(){
	var provision = $("[id^=provision]");
	var id = '';
	var result = 0;
	var buy_now_gr = 0;
	provision.each(function(){
		id = getId($(this));
		buy_now_gr = parseFloat($('#buy_now_gr'+id).prop('innerText'));

		if(buy_now_gr <= 100){
			result = buy_now_gr*0.06;
		}else if(buy_now_gr <= 1000){
			result = (buy_now_gr-100)*0.03 + 6;
		}else if(buy_now_gr <= 5000){
			result = (buy_now_gr-1000)*0.015 + 33;
		}else{
			result = (buy_now_gr - 5000)*0.005 + 93;
		}
		$(this).html(result.toFixed(2));
	});
}

$(document).ready( function(){
	calc_purchase_net_pl();
	calc_buy_now_net();
	cals_prod_plus_delivery();
	calc_delivery_trim();
	calc_provision();
});