$(function() {
	$('#ruleCategory').change(function(e) {
		var self = $(e.target);
		if (self.val() == 1) {
			tmp = $('#rate-div').children().remove();
		} else {
			if ($('#rate-div').children().size() === 0 && tmp !== null) {
				$('#rate-div').append(tmp);
			}
		}
	});

	$.validator.addMethod("regex", function(value, element, regexp) {
		var re = new RegExp(regexp);
		return this.optional(element) || re.test(value);
	}, "Please check your input.");

	$.datepicker.setDefaults($.datepicker.regional["zh-CN"]);

	$('.datepicker').datepicker({
		minDate : 0,
		dateFormat : 'yy-mm-dd',
		changeMonth : true,
		changeYear : true
	});

	$('#form').validate({
		onkeyup : false,
		rules : {
			name : {
				required : true,
				remote : {
					url : global.context + '/admin/cardRules/name/duplicate',
					data : {
						name : function() {
							return $('#name').val();
						}
					}
				},
				minlength : 4,
				maxlength : 20
			},
			card : {
				required : true
			},
			ruleCategory : {
				required : true
			},
			beginTime : {
				dateISO : true,
				required : function() {
					return $('#endTime').val() !== '';
				},
				before : 'endTime'
			},
			endTime : {
				dateISO : true,
				required : function() {
					return $('#beginTime').val() !== '';
				},
				after : 'beginTime'
			},
			score : {
				digits : true,
				required : true
			},
			rate : {
				number : true,
				regex : '^[0-9]+\\.[0-9]$'
			}
		},
		messages : {
			name : {
				required : '规则名称不能为空',
				remote : '名称不能重复',
				minlength : '最小长度为4',
				maxlength : '最大长度为20'
			},
			card : {
				required : '所属会员卡不能为空'
			},
			beginTime : {
				dateISO : '请输入正确的日期格式yyyy-mm-dd',
				required : '请输入开始日期',
				before : '开始日期应小于截止日期'
			},
			endTime : {
				dateISO : '请输入正确的日期格式yyyy-mm-dd',
				required : '请输入截止日期',
				after : '截止日期应小于开始日期'
			},
			ruleCategory : {
				required : '积分类型不能为空'
			},
			score : {
				digits : '请输入整数',
				required : '不能为空'
			},
			rate : {
				number : '请输入数字',
				regex : '小数点后一位'
			}
		}
	});
});