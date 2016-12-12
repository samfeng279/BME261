values = csvread('turnFINAL.csv'); %change per file name
dt = 0.1; %change to reflect 'delay' in Arduino file

pitch = values(:, 1);
AcX = values(:, 2);
AcY = values(:, 3);
AcZ = values(:, 4);
GyX = values(:, 5);
GyY = values(:, 6);
GyZ = values(:, 7);

%PITCH
timepitch = linspace(0, dt*length(pitch), length(pitch));
figure
plot(timepitch, pitch), xlabel('Time(s)'), ylabel('pitch angle'), title('pitch angle') 

% %ACCELERATION ON X AXIS:
% timeAcX = linspace(0, dt*length(AcX), length(GyY));
% figure
% plot(timeAcX, AcX), xlabel('Time(s)'), ylabel('Acceleration (Counts)'), title('Acceleration on X-Axis')
% 
% %ACCELERATION ON Y AXIS:
% timeAcY = linspace(0, dt*length(AcY), length(AcY));
% figure
% plot(timeAcY, AcY), xlabel('Time(s)'), ylabel('Acceleration (Counts)'), title('Acceleration on Y-Axis')
% 
% %ACCELERATION ON Z AXIS:
% timeAcZ = linspace(0, dt*length(AcZ), length(AcZ));
% figure
% plot(timeAcZ, AcZ), xlabel('Time(s)'), ylabel('Acceleration (Counts)'), title('Acceleration on Z-Axis')

%ANGULAR ACCELERATION ABOUT X AXIS:
timeGyX = linspace(0, dt*length(GyX), length(GyX));
figure
plot(timeGyX, GyX), xlabel('Time(s)'), ylabel('Angular Acceleration (Counts)'), title('Angular Acceration about X-Axis')

%ANGULAR ACCELERATION ABOUT Y AXIS:
timeGyY = linspace(0, dt*length(GyY), length(GyY));
figure
plot(timeGyY, GyY), xlabel('Time(s)'), ylabel('Angular Acceleration (Counts)'), title('Angular Acceleration about Y Axis')

%ANGULAR ACCELERATION ABOUT Z AXIS:
timeGyZ = linspace(0, dt*length(GyZ), length(GyZ));
figure
plot(timeGyZ, GyZ), xlabel('Time(s)'), ylabel('Angular Acceleration (Counts)'), title('Angular Acceleration about Z-Axis')