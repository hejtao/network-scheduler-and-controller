function [exectime, data] = update_u_code(seg, data)

%updata

switch seg
 case 1
  data.temp = ttGetMsg(1);   %c2a GTS
  if ~isempty(data.temp)
     ttTryPost('update_u', data.temp(1:10,:));  
     ttTryPost('gap', data.temp(11,:));
     ttSetNextSegment(4);
  end
  exectime = 0.0005;
  
 case 2
  data.temp = ttGetMsg(2);   %c2a CAP
  if ~isempty(data.temp)            
     ttTryPost('update_u', data.temp(1:10,:));
     ttTryPost('gap', data.temp(11,:));
     ttSendMsg([3 2], data.ACK, 10);
     ttSetNextSegment(4);
  end  
  exectime = 0.0005;
  
 case 3
  data.gap = ttGetMsg(3);
  if data.gap == data.SEN_HOLD;
     ttTryPost('gap', 0);
  elseif data.gap == data.UPDATA_GAP
     ttTryPost('gap', 1);
  end
  exectime = 0.0005;
  
 case 4
  exectime = -1;  % finished  
  
end
