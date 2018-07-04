function [exectime, data] = act_code(seg, data)

%apply the control signals u to the plant

persistent u; 
persistent i;

switch seg
 case 1
  data.u = ttTryFetch('update_u');  
  exectime = 0.0001;
  if ~isempty(data.u)
      u = data.u;
      i = 1;
  end
  
  %initialize u,i if no data is received
  if isempty(u)                      
      u = [0;0;0;0;0;0;0;0;0;0];
  elseif isempty(i)
      i = 1;
  end
   
  if i>10
      i=10;  
  end
  
  ttAnalogOut(1, u(i,:))
  if i == 10
      ttTryPost('last_u', [u(i,:),0,0]);
  elseif i == 9
      ttTryPost('last_u', [u(i,:),u(i+1,:),0]);
  else
      ttTryPost('last_u', [u(i,:),u(i+1,:),u(i+2,:)]);
  end
  
  i = i+1;
  exectime = 0.001;
  
 case 2
  exectime = -1; % finished
end
