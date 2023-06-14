clear all
close all
clc

%Preliminary test program for the acquisition of acc values

disp('Open the Matlab app on your smartphone')
disp('Connect to device...')
dev_name = 'iPhone - iPhone di giulio';
while 1
try
    m = mobiledev(dev_name);
catch 
    disp('Device not connected.')
    pause(10)
    continue
end
break
end

disp('Device connected.')
disp('Start inizialization...');
m.AccelerationSensorEnable = 1;
m.SampleRate = 10; % [S/s]
Ts = 1/m.SampleRate; %[s] sampling period
Tplay = 2; %[min] play time
Tsplay = Tplay*60; %[seconds] play time
Tpause = 0.5;
disp('Initialization completed.');


%random generations of the coins
coin = zeros(2,4);
for i=1:1:4
        coin(1,i) = round(-10 + 20*rand(1));
        coin(2,i) = round(-10 + 20*rand(1));
end

%calibration of the accelerometer
offset_x = -0.21;
offset_y = -0.6;

%Start game
disp('Start Game...')
xmax = 10; ymax =10; %max state value
s = [0 0]; %inizialize state
m.Logging = 1; %start transmission
pause(1) %pause needed for establishing the transm

%inizialize figure
figure(2)
c = plot(coin(1,:), coin(2,:),'yo', 'MarkerEdgeColor','b','MarkerFaceColor','y');
hold on
h = plot(s(1), s(2),'ks','MarkerFaceColor','k');
xlim([-xmax, xmax])
ylim([-ymax, ymax])
xlabel('Xposition')
xlabel('Yposition')
drawnow

%Start timer
threshold = 2; %value of acc beyond which to go ahead
delta_x = 0.5;
delta_y = 0.5;
coin_count = 0;
old_buffersize = 0; % for connection control
first_check = 0;

%Start timer
Tgame = 0;
Tin = tic();
z = 0;

while Tgame < Tsplay
    [log, timestap] = accellog(m);
    log = log; %- [offset_x , offset_y , 0]; %use the calibrated values
    
    % Connection control
    if length(timestamp) <= old_buffersize
        disp('Connection lost, please turn on your device...')
        continue
    end
    old_buffersize = length(timestamp);

    %Reset
    Treset = 0;
    if abs(log(end,1)) < threshold && abs(log(end,2)) < threshold && first_check == 0
        first_check = 1;
        Tinreset = tic();
    elseif abs(log(end,1)) < threshold && abs(log(end,2)) < threshold && first_check == 1
        Treset = toc(Tinreset);
        if(Treset >= 10)
            disp('RESETTING THE GAME')
            s = [0 , 0]; %RETURN TO THE INISTIAL POSITION
            coin_count = 0; %reset the coin counter and generate new coins
            for i=1:1:4
                coin(1,i) = round(-10 + 20*rand(1));
                coin(2,i) = round(-10 + 20*rand(1));
            end
            Tin = tic();
            first_check = 0;
        end
    else
        first_check = 0;
    end


    %initial movements in both direction are null
    dirx = 0; 
    diry = 0;
    if log(end,1) > threshold %[m/s]
        dirx = -1;
    elseif log(end,1) < -threshold %[m/s]
        dirx = +1;
    end
    
    if log(end,2) > threshold %[m/s]
        diry = -1;
    elseif log(end,2) < -threshold %[m/s] 
        diry = +1;
    end

    % up-date new state
    s(1) = s(1) + delta_x*dirx;
    refreshdata
    s(2) = s(2) + delta_y*diry;

    % control margin
    if(s(1) > xmax) 
        s(1) = -xmax;
    elseif(s(1) < -xmax)
        s(1) = xmax;
    end

    if(s(2) > ymax) 
        s(2) = -ymax;
    elseif(s(2) < -ymax)
        s(2) = ymax;
    end
   

    %increment the coin counter
    for i=1:1:4
        if s(1) == coin(1,i) && s(2) == coin(2,i)
            coin_count = coin_count + 1; %increment counter coin
            coin(1,i) = 20; %assigned out of the map
            coin(2,i) = 20;
        end
    end

    figure(2)
    set(c, 'XData', coin(1,:),'YData', coin(2,:));
    set(h, 'XData', s(1),'YData', s(2));
    drawnow
    
    
    if coin_count == 4
        disp('YOU WIN CONGRATULATION')
        break
    end

Tgame = toc(Tin)
z=z+1;
end
Tcycle = Tgame/z
%R-T function for control position of a marker: %flashdata %drawnow
if(coin_count ~= 4)
    disp('TIME EXPIRED, GAME OVER')
end