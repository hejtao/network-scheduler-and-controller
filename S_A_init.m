function S_A_init

ttInitKernel('prioFP');  

ttCreateMailbox('update_u', 50);   % 'update_u_task' send message(u) to 'act_task'
ttCreateMailbox('last_u', 50);     % 'act_task' send message(sample) to 'sen_task'
ttCreateMailbox('gap', 10);        % 'act_task' send message(gap) to 'sen_task'

% Periodic sensor task
starttime = 0.0;
period = 0.0614;
data.x=[0 0];                      %the sampled state
data.gap = 0;
data.last_u = [0 0 0];
ttCreatePeriodicTask('sen_task', starttime, period, 'sen_code',data);

% actuator task
starttime = 0.0614;
period = 0.0614;
deadline = 0.002;
data.u = [0;0;0;0;0;0;0;0;0;0]; 
data.temp = [0;0;0;0;0;0;0;0;0;0;0];
data.SEN_HOLD = 10;
data.ACK = 5;
data.UPDATA_GAP = 15;
ttCreatePeriodicTask('act_task', starttime, period, 'act_code', data);
ttCreateTask('update_u_task', deadline, 'update_u_code', data);
ttAttachNetworkHandler(1,'update_u_task')      %task/handler will be invoked every time the control
ttAttachNetworkHandler(2,'update_u_task')      % message arrives over the network
ttAttachNetworkHandler(3,'update_u_task')

