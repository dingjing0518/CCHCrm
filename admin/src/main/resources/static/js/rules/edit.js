$(function() {
	//首次加载全选框选中状态
	$(".shopCategoryJson").each(function(){
		var $shopList=$(this).find(".shop");
		var $chekedShop=$(this).children().eq(1).find("input[type='checkbox']:checked");
		if($shopList.length==0){
			$(this).find(".category").attr("checked",false);
		}else {
			$(this).find(".category").attr("checked",$shopList.length==$chekedShop.length?true:false);
		}
	});
	//反选
	$(".shopCategoryJson").on("click",".shop",function(){
		var $checkAll=$(this).parent().parent().parent().parent().find(".category");
		var $shops=$(this).parent().parent().parent().find(".shop");
		var $checked=$(this).parent().parent().parent().find("input[type='checkbox']:checked");
		$checkAll.attr("checked",$shops.length == $checked.length ? true : false);
	});
	//全选全不选
	$("#form").on("click",".category",function(){
		$(this).parent().parent().parent().find("input").attr("checked",this.checked);
	});
	$.validator.addMethod("regex", function(value, element, regexp) {
		var re = new RegExp(regexp);
		return this.optional(element) || re.test(value);
	}, "Please check your input.");

	$('button.confirm').click(function() {
		$('.success-modal,.fixed').show().delay(2000).fadeOut(500);
	})

	$('#valid-button').confirm({
		formId : '#validForm'
	});

	$('#form').validate({
		onkeyup : false,
		rules : {
			name : {
				required : true,
				remote : {
					url : global.context + '/admin/rules/name/duplicate',
					data : {
						name : function() {
							return $('#name').val();
						},
						id : function() {
							return $('#form').attr('data-id');
						}
					}
				},
				minlength : 1,
				maxlength : 20
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
				regex : '^[0-9]+\\.[0-9]$|^[0-9]+$'
			}
		},
		messages : {
			name : {
				required : '规则名称不能为空',
				remote : '规则名称不能重复',
				minlength : '名称长度应在1-20个字符',
				maxlength : '名称长度应在1-20个字符'
			},
			beginTime : {
				dateISO : '请输入正确的日期格式yyyy-mm-dd',
				required : '请输入生效日期',
				before : '生效日期应早于失效日期'
			},
			endTime : {
				dateISO : '请输入正确的日期格式yyyy-mm-dd',
				required : '请输入失效日期',
				after : '失效日期应晚于生效日期'
			},
			score : {
				digits : '请输入整数'
			},
			rate : {
				number : '请输入数字',
				regex : '精确到小数点后1位（例如:1.0）'
			},
			shops : {
				required : '活动店铺不能为空'
			}
		},
		errorPlacement: function(error, element) {
			if (element.is(":checkbox")||element.is(":radio")){
				error.insertBefore(element.parent().parent().parent());
			}else {
				error.insertAfter(element);
			}
		}
	});

	$.datepicker.setDefaults($.datepicker.regional["zh-CN"]);

	$('.datepicker').datepicker({
		dateFormat : 'yy-mm-dd',
		changeMonth : true,
		changeYear : true
	});

	$('#beginTime').blur(function() {
		$('#form').validate().element('#endTime');
	});

	$('#endTime').blur(function() {
		$('#form').validate().element('#beginTime');
	});
});