$(function() {
	$.validator.addMethod("regex", function(value, element, regexp) {
		var re = new RegExp(regexp);
		return this.optional(element) || re.test(value);
	}, "Please check your input.");

	$('#form').validate({
		onkeyup : false,
		rules : {
			name : {
				required : true,
				remote : {
					url : global.context + '/admin/shopRules/name/duplicate',
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
			score : {
				digits : true
			},
			rate : {
				number : true,
				regex : '^[0-9]+\\.[0-9]$'
			},
			shops : {
				required : true
			}
		},
		messages : {
			name : {
				required : '规则名称不能为空',
				remote : '规则名称不能重复'
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
				digits : '请输入整数'
			},
			rate : {
				number : '请输入数字',
				regex : '小数点后只能有一位'
			},
			shops : {
				required : '活动店铺不能为空'
			}
		}
	});

	$.datepicker.setDefaults($.datepicker.regional["zh-CN"]);

	$('.datepicker').datepicker({
		dateFormat : 'yy-mm-dd',
		changeMonth : true,
		changeYear : true,
		minDate : new Date()
	});
});
