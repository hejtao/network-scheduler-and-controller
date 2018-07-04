function [exectime, data] = sen_code(seg, data)

persistent gap;

switch seg
    
 case 1
  data.x(1) = ttAnalogIn(1);
  data.x(2) = ttAnalogIn(2);
  
  data.gap = ttTryFetch('gap');
  if ~isempty(data.gap)
      gap = data.gap;
  end
  
  if isempty(gap)
      gap = 1;
  end
  exectime = 0.0005;
  
 case 2  
  data.last_u = ttTryFetch('last_u');
  if isempty(data.last_u)
      data.last_u = [0 0 0];
  end
  
  if gap == 3
    ttSendMsg([2 2], [data.x, 3, data.last_u], 80); %CAP
  end
  
  if gap == 2
    ttSendMsg([2 2], [data.x, 2, data.last_u], 80); %CAP
  end
  
  if gap == 1
    ttSendMsg([1 2], [data.x, 1, data.last_u], 80); %GTS  
  end
  
  gap = gap-1;
  
  exectime = -1;
  
end
