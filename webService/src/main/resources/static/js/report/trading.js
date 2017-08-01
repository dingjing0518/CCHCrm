$(function () {
    var months = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
        margin = {left: 30, right: 60, bottom: 30, top: 20},
        width = $('div.container').width() - margin.left - margin.right,
        height = 450 - margin.bottom - margin.top,
        xScale = d3.scale.linear().range([0, width]),
        yScale = d3.scale.linear().range([height, 0]),
        url = global.context + '/admin/tradingReport/data';

    var xAxis = d3.svg.axis().scale(xScale).orient('bottom');
    var yAxis = d3.svg.axis().scale(yScale).orient('left');

    var r = 10;

    d3.json(url, function (error, data) {
        if (error)
            console.log(error);
        draw(data);
    });

    d3.select('#year').on('change', function () {
        var year = d3.select(this)[0][0].value;

        d3.json(url + '?year=' + year, function (err, data) {
            if (err)
                throw err;

            reDraw(data);
        });
    });

    function reDraw(data) {

        data.forEach(function (d) {
            d.numbers = +d.number;
            d.amounts = +d.amount;
        });

        yScale.domain([0, d3.max(data, function (d) {
            return d.amounts;
        })]).nice();
        xScale.domain([0, d3.max(data, function (d) {
            return d.numbers;
        })]).nice();

        yAxis = d3.svg.axis().scale(yScale).orient('left');
        xAxis = d3.svg.axis().scale(xScale).orient('bottom');

        d3.select('#xAxis').call(xAxis);
        d3.select('#yAxis').call(yAxis);

        var circle = d3.select('svg')
            .selectAll('g.circle-point')
            .data(data, function (d) {
                return d.time;
            });

        circle.enter()
            .append('g')
            .attr('class', 'circle-point')
            .attr("transform", function (d) {
                return 'translate(' + xScale(d.numbers) + ',' + yScale(d.amounts) + ')';
            });

        circle.exit().remove();

        d3.selectAll('g.circle-point')
            .append('circle')
            .style("fill", "pink")
            .style("stroke", "black")
            .style("stroke-width", "1px")
            .attr('r', r);

        d3.selectAll('g.circle-point')
            .append('text')
            .style("text-anchor", "middle")
            .attr('y', 2 * r)
            .style("font-size", "10px")
            .text(function (d) {
                return d.month;
            });
    }

    function draw(data) {

        var svg = d3.select('div.container').append('svg')
            .attr('width', width + margin.left + margin.right)
            .attr('height', height + margin.bottom + margin.top).append('g')
            .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

        data.forEach(function (d) {
            d.numbers = +d.number;
            d.amounts = +d.amount;
        });

        yScale.domain([0, d3.max(data, function (d) {
            return d.amounts;
        })]).nice();
        xScale.domain([0, d3.max(data, function (d) {
            return d.numbers;
        })]).nice();

        svg.selectAll('g')
            .data(data, function (d) {
                return d.time;
            })
            .enter()
            .append('g')
            .attr('class', 'circle-point')
            .attr("transform", function (d) {
                return 'translate(' + xScale(d.numbers) + ',' + yScale(d.amounts) + ')';
            });

        svg.append('g')
            .attr('id', 'xAxis')
            .attr('class', 'x axis')
            .attr("transform", "translate(0," + height + ")")
            .call(xAxis);

        svg.append('g').attr('id', 'yAxis').attr('class', 'y axis').call(yAxis);

        var circle = svg.selectAll('g.circle-point');

        circle
            .append('circle')
            .style("fill", "pink")
            .style("stroke", "black")
            .style("stroke-width", "1px")
            .attr('r', r);

        circle
            .append('text')
            .style("text-anchor", "middle")
            .attr('y', 2 * r)
            .style("font-size", "10px")
            .text(function (d) {
                return d.month;
            });
    }
});