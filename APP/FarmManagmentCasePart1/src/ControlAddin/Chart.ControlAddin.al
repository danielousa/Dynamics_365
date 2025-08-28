controladdin "Chart Control"
{
    RequestedHeight = 600;
    MinimumHeight = 400;
    MaximumHeight = 600;
    RequestedWidth = 700;
    MinimumWidth = 700;
    MaximumWidth = 700;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    Scripts = 
        'https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js', 'src/Charts/chartbc.js';
    StyleSheets =
        'src/Style/Style.css';
    StartupScript = 'src/Script/start.js';
    // RecreateScript = 'recreateScript.js';
    // RefreshScript = 'refreshScript.js';
    // Images = 
    //     'image1.png',
    //     'image2.png';
    
    event ControlReady()
    
    procedure drawChart(ChartLabels: JsonArray; Data: JsonArray)
}