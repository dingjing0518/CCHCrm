$(function() {
	$("#info-reset").click(function(){
		var name=$("#name").text();
		var msg = "确认重置该用户的密码？";
		if (confirm(msg)==true){
			$.ajax({
				type:"POST",
				url:global.context + '/admin/users/resetPassword',
				data:{name:name},
				dataType:"text",
				success:function(data){
					if(data=="success"){
						alert("密码重置成功！");
					}
				}

			});
			return true;
		}else{
			return false;
		}
	});
	$('#validate-button').confirm({
		formId:'#validForm'
	});
	$('#form').validate({
		onkeyup : false,
		rules : {
			password : {
				required : true
			}
		},
		messages : {
			password : {
				required : '密码不能为空'
			}
		}
	});
});