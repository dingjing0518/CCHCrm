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
		tmpl : 'parking',
		tabDetail : '#t5',
		pageId : 'parkingPage'
	}, {
		tmpl : 'giftCoupons',
		tabDetail : '#t6',
		pageId : 'giftCouponsPage'
	}, {
		tmpl : 'shopCoupons',
		tabDetail : '#t7',
		pageId : 'shopCouponsPage'
	}, {
		tmpl : 'parkingCoupons',
		tabDetail : '#t8',
		pageId : 'parkingCouponsPage'
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
		$(tab).click(function() {
			var self = $(this);
			var id = self.attr('data-id');
			var row = '#' + obj.tmpl + '-row';
			$.ajax({
				url : global.context + '/admin/members/' + id + suffix,
				success : function(data) {
					var html = consumeTmpl[cacheName].render(data.obj);
					$(obj.tabDetail).html(html);
					if (obj.pageId != null) {
						$('#' + obj.pageId).pageable({
							url : '/admin/members/' + id + '/' + obj.tmpl,
							parameter : function() {
								return {};
							},
							fn : function(data) {
								var html = consumeTmpl[row].render(data.obj);
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
		if (new Number(score) > new Number(availableScore)) {
			$(this).after('<div>扣减的积分不应大于用户积分</div>');
			$('#minusScore').val('');
			return;
		}
		$.ajax({
			url : global.context + '/admin/members/score/minus',
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			type : 'put',
			data : JSON.stringify({
				id : id,
				score : score
			}),
			success : function(data) {
				$('#minus-val').val(0);
				$('#availableScore').val(data.obj);
				dialog.dialog('close');
			}
		})
	};

	var addScore = function() {
		var score = $('#addScore').val();
		var id = $('#dialog-add').attr('member');
		$.ajax({
			url : global.context + '/admin/members/score/add',
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			type : 'put',
			data : JSON.stringify({
				id : id,
				score : score
			}),
			success : function(data) {
				$('#addScore').val('');
				$('#availableScore').val(data.obj);
				var sumScore = $('#sumScore');
				sumScore.html(new Number(sumScore.html()) + new Number(score));
				addDialog.dialog('close');
			}
		})
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
});