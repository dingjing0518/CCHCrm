$(function() {
	$.datepicker.setDefaults($.datepicker.regional["zh-CN"]);

	$('.datepicker').datepicker({
		dateFormat : 'yy-mm-dd',
		changeMonth : true,
		changeYear : true
	});

	$('#form').validate({
		onkeyup : false,
		rules : {
			'memberDetail.realName' : {
				minlength : 2,
				maxlength : 10,
			},
			name : {
				digits:true,
				required : true,
				minlength : 11,
				maxlength : 11,
				remote : {
					url : '/admin/members/duplicate',
					data : {
						name : $('#mobile').val()
					}
				}
			},
			'memberDetail.birthday' : {
				dateISO : true
			},
			'memberDetail.address' : {
				maxlength : 200
			}
		},
		messages : {
			'memberDetail.realName' : {
				minlength : '最短长度为2',
				maxlength : '最大长度为10'
			},
			name : {
				digits:'请输入数字',
				required : '请输入手机号',
				remote : '手机号不能重复',
				minlength : '手机号为11位',
				maxlength : '手机号为11位'
			},
			'memberDetail.birthday' : {
				dateISO : '请输入正确的日期格式yyyy-mm-dd'
			},
			'memberDetail.address' : {
				maxlength : '长度小于200'
			}
		}
	});
})