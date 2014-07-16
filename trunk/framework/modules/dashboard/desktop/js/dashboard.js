        $(function() 
        {
            var data = [{
                label: "Presupuestos",
                data: 40
            },
            {
                label: "Cancelados",
                data: 20
            },
            {
                label: "En Proceso",
                data: 10
            },
            {
                label: "Terminados",
                data: 30
            }];

            var options = {
                series: {
                    pie: {
                        show: true,
                        innerRadius: 0.5,
                        show: true
                    }
                },
                legend: {
                    show: true
                },
                grid: {
                    hoverable: true,
                    clickable: true
                },
                colors: ["#79D1CF", "#D9DD81", "#E67A77","#9972B5"],
                tooltip: true,
                tooltipOpts: {
                    defaultTheme: true
                }
            };
            $.plot($("#pie-chart-donut #pie-donutContainer"), data, options);
        });



if (Gauge) {
    /*Knob*/
    var opts = {
        lines: 12, // The number of lines to draw
        angle: 0, // The length of each line
        lineWidth: 0.48, // The line thickness
        pointer: {
            length: 0.6, // The radius of the inner circle
            strokeWidth: 0.03, // The rotation offset
            color: '#464646' // Fill color
        },
        limitMax: 'true', // If true, the pointer will not go past the end of the gauge
        colorStart: '#fa8564', // Colors
        colorStop: '#fa8564', // just experiment with them
        strokeColor: '#F1F1F1', // to see which ones work best for you
        generateGradient: true
    };


    var target = document.getElementById('gauge'); // your canvas element
    var gauge = new Gauge(target).setOptions(opts); // create sexy gauge!
    gauge.maxValue = 500000; // set max gauge value
    gauge.animationSpeed = 50; // set animation speed (32 is default value)
    gauge.set(250000); // set actual value
    //gauge.setTextField(document.getElementById("gauge-textfield"));

}