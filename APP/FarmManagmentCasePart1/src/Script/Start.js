document.getElementById("controlAddIn")
        .insertAdjacentHTML('beforeend','<img style= "display: block; margin-left: auto; margin-right: auto; width: 50%;" src="' +
                            Microsoft.Dynamics.NAV.GetImageResource('src/Resources/Logo.png') +
                            '">');




Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlReady', []);