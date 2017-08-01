$(function () {

	var myChart = echarts.init(document.getElementById('main'), 'macarons');
	var myChart2 = echarts.init(document.getElementById('main2', 'macarons'));
	
	var data = {
			startTime:startDay,
			endTime:endDay,
    };

	htmlobj=$.ajax({url:global.context + '/admin/tradingAnalysisReport/data',data:data,async:false});
		
	option = JSON.parse(htmlobj.responseText);
	
	myChart.setOption(option[0]);
	myChart2.setOption(option[1]);
	
	myChart.on('click', function (params) {
        if (params.name == "1F")
            myChart2.setOption(option[1]);

        if (params.name == "2F")
            myChart2.setOption(option[2]);
        
        if (params.name == "3F")
            myChart2.setOption(option[3]);

        if (params.name == "4F")
            myChart2.setOption(option[4]);
        
        if (params.name == "5F")
            myChart2.setOption(option[5]);
        
        if (params.name == "B1F")
            myChart2.setOption(option[6]);
    });
});