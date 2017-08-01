/**
 * Created by yagamai on 16-1-12.
 */
$(function() {
	$('textarea').ckeditor();

	$('#summary').count({
		total : 500
	});

	$('div.upload').change(function(event) {
		var source = $(event.target);
		var id = source.attr('id');
		var img = source.parent().parent().find('img');
		var input = source.siblings().last();
		$.ajaxFileUpload({
			url : global.context + '/admin/upload',
			secureuri : false,
			fileElementId : source.attr('id'),
			dataType : 'json',
			success : function(data, status) {
				if (status == 'success') {
					img.attr('src', global.url + data.responseText);
					input.val(global.url + data.responseText);
				}
			},
			error : function(data, status, e) {
				alert(e);
			}
		});
		return false;
	});

	$.datepicker.setDefaults($.datepicker.regional["zh-CN"]);

	$('.datepicker').datepicker({
		minDate : 0,
		dateFormat : 'yy-mm-dd',
		changeMonth : true,
		changeYear : true
	});

	var url = global.context + '/admin/parkingCoupons/name/duplicate';

	$('#form').validate({
		onkeyup : false,
		rules : {
			name : {
				required : true,
				remote : {
					url : url,
					data : {
						name : function() {
							return $('#name').val();
						}
					}
				}
			},
			beginTime : {
				dateISO : true,
				required : function() {
					return $('#endTime').val() != '';
				},
				before : 'endTime'
			},
			endTime : {
				dateISO : true,
				required : function() {
					return $('#beginTime').val() != '';
				},
				after : 'beginTime'
			},
			couponEndTime : {
				dateISO : true
			},
			amount : {
				required : true,
				number : true
			},
			score : {
				required : true,
				digits : true
			}
		},
		messages : {
			name : {
				required : '名称不能为空',
				remote : '名称不能重复'
			},
			couponEndTIme : {
				dateISO : '请输入正月的日期格式yyyy-mm-dd'
			},
			beginTime : {
				dateISO : '请输入正月的日期格式yyyy-mm-dd',
				required : '请输入开始日期',
				before : '开始日期应小于截止日期'
			},
			endTime : {
				dateISO : '请输入正月的日期格式yyyy-mm-dd',
				required : '请输入截止日期',
				after : '截止日期应小于开始日期'
			},
			score : {
				required : '积分不能为空'
			},
			amount : {
				required : '金额不能为空'
			}
		}
	});

	$('#beginTime').blur(function() {
		$('#form').validate().element('#endTime');
	});

	$('#endTime').blur(function() {
		$('#form').validate().element('#beginTime');
	});
});
