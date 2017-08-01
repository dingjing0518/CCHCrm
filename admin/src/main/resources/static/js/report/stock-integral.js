$(function () {
	var myChart = echarts.init(document.getElementById('main'), 'macarons');
	var htmlobj=$.ajax({url:global.context + '/admin/stockIntegralReport/data',async:false});
    var option = JSON.parse(htmlobj.responseText);
    myChart.setOption(option);
});