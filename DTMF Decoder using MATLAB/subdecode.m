axes(handles.fig1);
plot(t,y);
title('DTMF Input');xlabel('Time');
ylabel('Amplitude');grid;

rmain=2048*2;rmag=1024*2;
cn=9;cr=0.5;
cl=.25;ch=.28;                %variables
[b,a]=cheby1(cn,cr,cl);       %chebyl filter %9th order, 0.5db of passband ripple
yfilt1=filter(b,a,y);         %y is our input sound and we get b and a from chebyl filter 
axes(handles.fig2);
plot(yfilt1);grid;
title('Filtered Low Freq. Signal');
xlabel('Time');ylabel('Amplitude');


[b1,a1]=cheby1(cn,cr,ch,'high');
yfilt2=filter(b1,a1,y);      
axes(handles.fig3);
plot(yfilt2);grid;
title('Filtered High Freq. Signal');
xlabel('Time');ylabel('Amplitude');

hlow=fft(yfilt1,rmain);     %first take fft of low freq. 
hmaglow=abs(hlow);          %returns absolute value
axes(handles.fig4);
plot(hmaglow(1:rmag));       %plot hmaglow ranging from 1 to 2048
title('FFT Low Pass');grid;
xlabel('Time');ylabel('Amplitude');

hhigh=fft(yfilt2,rmain);    %take fft of high frq signals,ramin is size of yfilter2
hmaghigh=abs(hhigh);
axes(handles.fig5);
plot(hmaghigh(1:rmag));
title('FFT High Pass');grid;
xlabel('Time');ylabel('Amplitude');


h2=fft(yfilt1,rmain);
hmag2=abs(h2(1:rmag));
h3=fft(yfilt2,rmain);
hmag3=abs(h3(1:rmag));      
m=max(abs(hmag2));n=max(abs(hmag3));
o=find(m==hmag2);p=find(n==hmag3);
j=((o-1)*fs)/rmain;          %formula to get values for key detection
k=((p-1)*fs)/rmain;

if j<=732.59 & k<=1270.91;
   disp('---> Key Pressed is 1');
   elseif j<=732.59 & k<=1404.73;
      disp('---> Key Pressed is 2');
   elseif j<=732.59 & k<=1553.04;
      disp('---> Key Pressed is 3');
   elseif j<=732.59 & k>1553.05;
      disp('---> Key Pressed is A');
   elseif j<=809.96 & k<=1270.91;   
      disp('---> Key Pressed is 4');
   elseif j<=809.96 & k<=1404.73;
      disp('---> Key Pressed is 5');
   elseif j<=809.96 & k<=1553.04;
      disp('---> Key Pressed is 6');   
   elseif j<=809.96 & k>1553.05;
      disp('---> Key Pressed is B');  
   elseif j<=895.39 & k<=1270.91;
      disp('---> Key Pressed is 7');
   elseif j<=895.39 & k<=1404.73;
      disp('---> Key Pressed is 8');
   elseif j<=895.39 & k<=1553.04;
      disp('---> Key Pressed is 9');
   elseif j<=895.39 & k>1553.05;      
      disp('---> Key Pressed is C');   
   elseif j>895.40 & k<=1270.91;   
      disp('---> Key Pressed is *');
   elseif j>895.40 & k<=1404.73;  
      disp('---> Key Pressed is 0');
   elseif j>895.40 & k<=1553.04;  c
      disp('---> Key Pressed is #');
   elseif j>895.40 & k>1553.05;  
      disp('---> Key Pressed is D');
end