$(function () {
	var myChart = echarts.init(document.getElementById('main'), 'macarons');

	var year = $("#year");
	var season = $("#season");
	var month = $("#month");

	var data = {
		year:year.val(),
		season:season.val(),
		month:month.val()
	};

	var htmlobj=$.ajax({url:global.context + '/admin/tradingReport/data',data:data,async:false});
	var option = JSON.parse(htmlobj.responseText);
	myChart.setOption(option);

	$("#year").change(function(){
		if($("#month").val()<0&&$("#season").val()<0){
			alert("请选择季度或者月份！");
		}
		data = {
			year:year.val(),
			season:season.val(),
			month:month.val()
		};

		htmlobj=$.ajax({url:global.context + '/admin/tradingReport/data',data:data,async:false});
		option = JSON.parse(htmlobj.responseText);
		myChart.setOption(option);
	});

	$("#season").change(function(){
		if($("#year").val()<=0){
			alert("请选择年份！");
		}
		if($("#year").val()>0&&$("#month").val()>=0&&$("#season").val()>0){
			$("#month").val(-1);
		}
		data = {
			year:year.val(),
			season:season.val(),
			month:month.val()
		};

		htmlobj=$.ajax({url:global.context + '/admin/tradingReport/data',data:data,async:false});
		option = JSON.parse(htmlobj.responseText);
		myChart.setOption(option);
	});

	$("#month").change(function(){
		$("#season").val(0);
		if($("#year").val()<=0){
			alert("请选择年份！");
		}
		data = {
			year:year.val(),
			season:season.val(),
			month:month.val()
		};

		htmlobj=$.ajax({url:global.context + '/admin/tradingReport/data',data:data,async:false});
		option = JSON.parse(htmlobj.responseText);
		myChart.setOption(option);
	});

});