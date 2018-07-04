function con_init(arg)

ttInitKernel('prioFP') % deadline-monotonic scheduling

% Create task data (local memory)
data.sigma = arg;
data.u = [0;0;0;0;0;0;0;0;0;0];
data.x = [0 0];
data.s = 0;
data.last_u = [0 0 0];
data.temp = [0 0 0 0 0 0];
data.gap = 0;
data.SEN_HOLD = 10;
data.ACK = 5;
data.UPDATA_GAP = 15;
data.K=[45.0411   14.3995;
   37.1378   11.8730;
   30.3797    9.7133;
   25.0432    8.0079;
   20.5758    6.5801;
   17.1704    5.4916;
   13.9627    4.4661;
   12.5566    4.0161;
    9.4839    3.0339;
    5.9480    1.9037];
     
data.K2=[   37.1378   11.8730;
   30.3797    9.7133;
   25.0432    8.0079;
   20.5758    6.5801;
   17.1704    5.4916;
   13.9627    4.4661;
   12.5566    4.0161;
    9.4839    3.0339;
    5.9480    1.9037;
    6.4449    2.0619];

data.K3=[ 30.3797    9.7133;
   25.0432    8.0079;
   20.5758    6.5801;
   17.1704    5.4916;
   13.9627    4.4661;
   12.5566    4.0161;
    9.4839    3.0339;
    5.9480    1.9037;
    6.4449    2.0619;
    5.3134    1.6999];

deadline = 0.05;   

ttCreateTask('cal_task', deadline, 'cal_code', data);
ttAttachNetworkHandler(1,'cal_task')  %task/handler will be invoked every time the sensor
ttAttachNetworkHandler(2,'cal_task')  % message arrives over the network


