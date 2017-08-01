$(function () {
    var months = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
        margin = {left: 30, right: 60, bottom: 30, top: 20},
        width = $('div.container').width() - margin.left - margin.right,
        height = 450 - margin.bottom - margin.top,
        xScale = d3.scale.ordinal().rangeRoundBands([0, width], 0.3).domain(months),
        yScale = d3.scale.linear().range([height, 0]),
        url = global.context + '/admin/memberReport/data';

    var xAxis = d3.svg.axis().scale(xScale).orient('bottom');
    var yAxis = d3.svg.axis().scale(yScale).orient('left');

    d3.json(url, function (error, data) {
        if (error)
            console.log(error);
        draw(data);
    });

    d3.select('#year').on('change', function () {
        var year = d3.select(this)[0][0].value;

        d3.json(url + "?year=" + year, function (error, data) {
            var value = data.map(function (i) {
                return i.value;
            });

            var rect = d3.select('svg').select('g.canvas').selectAll('rect')
                .data(data, function (d) {
                    return d.time;
                });

            yScale.domain([0,d3.max(data.map(function(d){
            	return d.value;
            }))]);

            yAxis = d3.svg.axis().scale(yScale).orient('left');
            d3.selectAll('#yAxis').call(yAxis);

            rect.enter()
                .append('rect')
                .attr('class', 'rect-bar')
                .attr('y',function(){
                	return 0;
                })
                .attr("y", function (d) {
                    return yScale(d.value);
                })
                .attr("x", function (d, i) {
                    return xScale(d.key);
                })
                .attr('height',function(){
                	return 0;
                })
                .attr('height', function (d) {
                    return height - yScale(d.value);
                })
                .attr("width", xScale.rangeBand());
            rect.exit().remove();
        });
    });

    function draw(data) {

        var value = data.map(function (i) {
            return i.value;
        });

        var svg = d3.select('div.container').append('svg')
            .attr('width', width + margin.left + margin.right)
            .attr('height', height + margin.bottom + margin.top)
            .append('g')
            .attr('class', 'canvas')
            .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

            yScale.domain([0,d3.max(data.map(function(d){
            	return d.value;
            }))]);

        svg.append('g')
            .attr('id', 'xAxis')
            .attr('class', 'x axis')
            .attr("transform", "translate(0," + height + ")")
            .call(xAxis);

        svg.append('g')
            .attr('id', 'yAxis')
            .attr('class', 'y axis')
            .call(yAxis);

        svg.selectAll('rect')
            .data(data, function (d) {
                return d.time;
            })
            .enter()
            .append('rect')
            .attr('class', 'rect-bar')
            .attr("y", function (d) {
                return yScale(d.value);
            })
            .attr("x", function (d, i) {
                return xScale(d.key);
            })
            .attr('height', function (d) {
                return height - yScale(d.value);
            })
            .attr("width", xScale.rangeBand());
    }
});