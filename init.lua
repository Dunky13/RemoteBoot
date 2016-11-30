wifi.setmode(wifi.STATION)
wifi.sta.config("WiFi SSID","WiFi Password")
print(wifi.sta.getip())
testled = 0 -- Default led on NodeMCU for debugging purposes
led1 = 1    -- D1 pin
led2 = 2    -- D2 pin
gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)
gpio.mode(testled, gpio.OUTPUT)

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        buf = buf.."<html>";
        buf = buf.."<head>";
        buf = buf..'<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700" type="text/css">';
        buf = buf..'<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">';
        buf = buf..'<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">';
        buf = buf..'<link href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-material-design/4.0.2/bootstrap-material-design.min.css" rel="stylesheet">';
        
        buf = buf..'<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>';
        buf = buf..'<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>';
        buf = buf..'<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-material-design/4.0.2/bootstrap-material-design.umd.min.js"></script>';
        buf = buf..'<script>$(document).ready(function(){$.material.init();});</script>';
        buf = buf.."</head>";
        client:send(buf);
        buf = "";
        buf = buf.."<body>";
        buf = buf.."<div class='container'>";
        buf = buf.."<div class='row'>";
        buf = buf.."<div class='col-xs-3'>&nbsp;</div>";
        buf = buf.."<div class='col-xs-6'>";
        buf = buf.."<div class='page-header'><h1>Power My PC</h1></div>";
        buf = buf.."<table class='table table-striped table-hover'>";
        buf = buf.."<thead><tr><td>Button</td><td>Short</td><td>Long</td></tr></thead>";
        buf = buf.."<tbody>";
        buf = buf.."<tr><td>Test</td><td><a href=\"?pin=T1\" class='btn btn-raised btn-success'>Normal</a></td><td><a href=\"?pin=T1\" class='btn btn-raised btn-danger disabled'>Force</a></td></tr>";
        buf = buf.."<tr><td>Power</td><td><a href=\"?pin=N1\" class='btn btn-raised btn-success'>Normal</a></td><td><a href=\"?pin=F1\" class='btn btn-raised btn-danger disabled'>Force</a></td></tr>";
        buf = buf.."<tr><td>Reset</td><td><a href=\"?pin=N2\" class='btn btn-raised btn-success'>Normal</a></td><td><a href=\"?pin=F2\" class='btn btn-raised btn-danger disabled'>Force</a></td></tr>";
        buf = buf.."</tbody>";
        buf = buf.."</table>";
        buf = buf.."<div class='col-xs-3'>&nbsp;</div>";
        buf = buf.."</div>";
        buf = buf.."</body>";
        buf = buf.."</html>";
        client:send(buf);
        local _on,_off = "",""
        if(_GET.pin == "N1")then
              gpio.write(led1, gpio.HIGH);
              tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
              gpio.write(led1, gpio.LOW);
        elseif(_GET.pin == "F1")then
              gpio.write(led1, gpio.HIGH);
              tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
              tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
              tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
              tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
              tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
              gpio.write(led1, gpio.LOW);
        elseif(_GET.pin == "N2")then
              gpio.write(led2, gpio.HIGH);
              tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
              gpio.write(led2, gpio.LOW);
        elseif(_GET.pin == "F2")then
              gpio.write(led2, gpio.HIGH);
              tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
              tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
              tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
              tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
              tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
              gpio.write(led2, gpio.LOW);
        elseif(_GET.pin == "T1")then
              gpio.write(testled, gpio.HIGH);
              tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
              gpio.write(testled, gpio.LOW);      
        end
        client:close();
        collectgarbage();
    end)
end)
