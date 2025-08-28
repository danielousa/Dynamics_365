function drawChart(labels, data)
{
    var controlAddIn = document.getElementById("controlAddIn");

    var canvas = document.createElement("canvas");
    canvas.id = "myChart";
    canvas.setAttribute("width", "650");
    canvas.setAttribute("height", "550");
    controlAddIn.appendChild(canvas);

    var ctx = canvas.getContext('2d');

    var gradient = ctx.createLinearGradient(0, 0, 0, 400);
    gradient.addColorStop(0, '#29565a'); // Starting color
    gradient.addColorStop(0.5, '#41888d'); // Middle color
    gradient.addColorStop(1, '#65d2da'); // End color

    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Total Milk Production (liters)',
                data: data,
                backgroundColor: gradient,
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    gridLines: {
                        display: false // Hide grid lines on the Y-axis
                    },
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes: [{
                    gridLines: {
                        display: false // Hide grid lines on the X-axis
                    }
                }]
            }
        }
    });

}