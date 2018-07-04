function [exectime, data] = cal_code( segm, data)

switch segm
    case 1
        data.temp = ttGetMsg(1);   %GTS   get message from network 1
        if ~isempty(data.temp)
            data.x = data.temp(1:2);
            data.s = data.temp(3);
            data.last_u = data.temp(4:6);
            data.gap = self_tr(data.x, data.last_u, data.sigma);
            data.u = data.K*data.x';
            ttSendMsg([1 1], [data.u; data.gap], 80);  %Send 80 bits to node 1 (actuator)
            ttSetNextSegment(8);
        end     
        
        data.temp = ttGetMsg(2);    %CAP   get message from network 2
        if ~isempty(data.temp)
            data.x = data.temp(1:2);
            data.s = data.temp(3);
            data.last_u = data.temp(4:6);
        end
        if data.s == 3
            ttSetNextSegment(4);
        end
        exectime = 0.002;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 2    
        data.gap = self_tr2(data.x, data.last_u, data.sigma);
        if data.gap > 0
               ttSendMsg([3 1], data.SEN_HOLD, 10);
               ttSleep(0.0614);
        else
            ttSetNextSegment(8);
        end     
        exectime = 0.001;
        
    case 3
        data.u = data.K2*data.x';
        ttSendMsg([1 1], [data.u; data.gap], 80);    %GTS
        ttSetNextSegment(8);
        exectime = 0.001;
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 4
        data.gap = self_tr2(data.x, data.last_u, data.sigma);
        if data.gap > 0
            ttSendMsg([3 1], data.SEN_HOLD, 10);
            ttSleep(0.0614);
        else
            ttSetNextSegment(8);
        end   
        exectime = 0.001;
        
    case 5
        data.u = data.K2*data.x';
        ttSendMsg([2 1], [data.u; data.gap], 80);    %CAP
        exectime = 0.005;  
        
    case 6
        cap_success  = ttGetMsg(3);
        if cap_success == data.ACK
           ttSetNextSegment(8); 
        end
        
        data.gap = self_tr3(data.x, data.last_u, data.sigma);
        if data.gap == 0
            ttSendMsg([3 1], data.UPDATA_GAP, 10);
            ttSetNextSegment(8);
        end  
        ttSleep(0.0614);
        exectime = 0.002;
       
    case 7
        data.u = data.K3*data.x';
        ttSendMsg([1 1], [data.u; data.gap], 80);    %GTS
        exectime = 0.001;
        
    case 8 
        exectime = -1;       
end

