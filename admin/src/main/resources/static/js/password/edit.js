$(function() {
	$('#form').validate({
		onkeyup : false,
		rules : {
			oldPassword:{
				required:true,
				remote : {
					url : global.context + '/admin/password/duplicate',
					data : {
						oldPassword : function() {
							return $('#oldPassword').val();
						}
					}
				}
			},
			password : {
				required : true,
				minlength : 6
			},
			repeat : {
				required : true,
				minlength : 6,
				equalTo:'#password'
			}
		},
		messages : {
			oldPassword:{
				required:'请输入原密码',
				remote : '请输入正确的原密码'
			},
			password : {
				required : '请输入密码',
				minlength : '长度需大于6'
			},
			repeat : {
				required : '请确认密码',
				equalTo : '两次输入密码不一致',
				minlength : '长度需大于6'
			}
		},
		submitHandler:function(form){
			var password = $('#password').val();
			var repeat = $('#repeat').val();
			$.ajax({
				url : global.context + '/admin/password',
				type : 'put',
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify({
					password : password,
					repeat : repeat
				}),
				success : function(data) {
					console.log(data);
					if(data.status=='success'){
						alert("修改密码成功");
					}
				}
			});
		}
	});
});
