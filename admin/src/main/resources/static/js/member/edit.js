$(function() {
	var consumeTmpl = {};
	consumeTmpl.page = $.templates('#page-row');

	var array = [ {
		tmpl : 'use',
		tabDetail : '#t2'
	}, {
		tmpl : 'trading',
		tabDetail : '#t3',
		pageId : 'tradingPage'
	}, {
		tmpl : 'score',
		tabDetail : '#t4',
		pageId : 'scorePage'
	}, {
		tmpl : 'parkingPayHistory',
		tabDetail : '#t5',
		pageId : 'parkingPayHistoryPage'
	}, {
		tmpl : 'giftCoupons',
		tabDetail : '#t6',
		pageId : 'giftCouponsPage'
	}, {
		tmpl : 'shopCoupons',
		tabDetail : '#t7',
		pageId : 'shopCouponsPage'
	}, {
		tmpl : 'parkingCouponDetail',
		tabDetail : '#t8',
		pageId : 'parkingCouponDetailPage'
	} ];

	function init(obj) {
		var tab = '#' + obj.tmpl + 'Flow', tmplName = '#' + obj.tmpl + '-tmpl', cacheName = obj.tmpl, suffix = '/'
			+ obj.tmpl, table = '#' + obj.tmpl + 'Table tbody', row = '#'
			+ obj.tmpl + '-row';
		if (consumeTmpl[cacheName] == null) {
			consumeTmpl[cacheName] = $.templates(tmplName);
		}
		if (consumeTmpl[row] == null) {
			consumeTmpl[row] = $.templates(row);
		}
		$(tab).click(
			function() {
				var self = $(this);
				var id = self.attr('data-id');
				var row = '#' + obj.tmpl + '-row';
				$.ajax({
					url : global.context + '/admin/members/' + id + suffix,
					success : function(data) {
						var html = consumeTmpl[cacheName].render(data.obj);
						$(obj.tabDetail).html(html);
						if (obj.pageId != null) {
							$('#' + obj.pageId).pageable(
								{
									url : global.context
									+ '/admin/members/' + id
									+ '/' + obj.tmpl,
									parameter : function() {
										return {};
									},
									fn : function(data) {
										var html = consumeTmpl[row]
											.render(data.obj);
										$(table).children().remove();
										$(table).html(html);
									},
									totalPages : data.obj.totalPages,
									tmpl : consumeTmpl.page
								});
						}
					}
				});
			});
	}

	array.forEach(function(e) {
		init(e);
	});

	var minusScore = function() {
		var score = $('#minusScore').val();
		var id = $('#dialog-minus').attr('member');
		var availableScore = $('#availableScore').val();
		var minusRemark = $('#minusRemark').val();

		if (new Number(score) > new Number(availableScore)) {
			var minusalert = '<div id ="minusalert" class="alert alert-danger"></div>';
			var divminus = $('div.alert-danger.alert-miuns').text('扣减的积分不应大于用户积分').show();
			$(this).after(divminus);
			setTimeout(function() {
				divminus.hide();
			}, 1000);
			// $(this).after('<div class="red">扣减的积分不应大于用户积分</div>');
			$('#minusScore').val('');
			return;
		}
		if (score != '') {
			$.ajax({
				url : global.context + '/admin/members/score/minus',
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				type : 'put',
				data : JSON.stringify({
					id : id,
					score : score,
					remark : minusRemark
				}),
				success : function(data) {
					var div;
					if (data.status == 'success') {
						$('#minusScore').val('');

						var sumScore = $('#sumScore');
						var availScore = $('#availableScore');

						var newSum = new Number(sumScore.text())
							- new Number(score);
						var newAvail = new Number(availScore.val())
							- new Number(score);
						sumScore.html(newSum);
						$('#availableScore').val(newAvail);

						dialog.dialog('close');
						div = $('div.alert-success').text('保存成功').show();
					} else {
						$('#minusScore').val('');
						dialog.dialog('close');
						div = $('div.alert-danger').text('保存失败').show();
					}
					 setTimeout(function() {
					 		div.hide();
					 	}, 1000);
				}
			});
		} else {
			var minusalert = '<div id ="minusalert" class="alert alert-danger"></div>';
			var divminus = $('div.alert-danger.alert-miuns').text('请输入积分').show();
			$(this).after(divminus);
			setTimeout(function() {
				divminus.hide();
			}, 1000);
			// $(this).after('<div class="red">扣减的积分不应大于用户积分</div>');
			$('#minusScore').val('');
			return;
		}
	};

	var addScore = function() {
		var score = $('#addScore').val();
		var id = $('#dialog-add').attr('member');
		var addRemark = $('#addRemark').val();
		if (score != '') {
			$.ajax({
				url : global.context + '/admin/members/score/add',
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				type : 'put',
				data : JSON.stringify({
					id : id,
					score : score,
					remark : addRemark
				}),
				success : function(data) {
					var div;
					if (data.status == 'success') {
						$('#addScore').val('');
						var sumScore = $('#sumScore');
						var availScore = $('#availableScore');

						var newSum = new Number(sumScore.text())
							+ new Number(score);
						var newAvail = new Number(availScore.val())
							+ new Number(score);
						sumScore.html(newSum);
						$('#availableScore').val(newAvail);

						addDialog.dialog('close');
						div = $('div.alert-success').text('保存成功').show();
					} else {
						$('#addScore').val('');
						dialog.dialog('close');
						div = $('div.alert-danger').text('保存失败').show();
					}
					 setTimeout(function() {
					 	div.hide();
					 }, 1000);
				}
			});
		} else {
			var minusalert = '<div id ="minusalert" class="alert alert-danger"></div>';
			var divminus = $('div.alert-danger.alert-miuns').text('请输入积分').show();
			$(this).after(divminus);
			setTimeout(function() {
				divminus.hide();
			}, 1000);
			// $(this).after('<div class="red">扣减的积分不应大于用户积分</div>');
			$('#minusScore').val('');
			return;
		}
	};

	var dialog = $("#dialog-minus").dialog({
		autoOpen : false,
		width : 350,
		modal : true,
		buttons : {
			"确认" : minusScore,
			"取消" : function() {
				dialog.dialog("close");
			},
		},
		close : function() {
			dialog.dialog('close');
		}
	});

	var addDialog = $('#dialog-add').dialog({
		autoOpen : false,
		width : 350,
		modal : true,
		buttons : {
			"确认" : addScore,
			"取消" : function() {
				addDialog.dialog("close");
			}
		},
	});

	$('body').on('click', 'a.minus', function() {
		dialog.dialog('open');
	});

	$('body').on('click', 'a.plus', function() {
		addDialog.dialog('open');
	});

	$('#valid').confirm({
		formId : '#validForm'
	});
	$("#dialog-add").keydown(function(event) {
		if (event.keyCode == "13") {// keyCode=13是回车键
			addScore();
			return false;
		}
	});
	$("#dialog-minus").keydown(function(event) {
		if (event.keyCode == "13") {// keyCode=13是回车键
			minusScore();
			return false;
		}
	});
});