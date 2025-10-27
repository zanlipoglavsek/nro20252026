clc; clear all;

% 1. naloga
filename = "naloga1_1.txt";
podatki = importdata(filename);
t = podatki.data;

% 2. naloga
P = zeros(100, 1);
file_id = fopen("naloga1_2.txt", "r");
for i = 1:1:101
    line = fgetl(file_id);
    %fprintf('%s\n', line);
    if i>1
        P(i-1,1) = str2double(line);
    end
end
fclose(file_id);

figure(1)
plot(t, P)
xlabel('t[s]')
ylabel('P[W]')
title('graf P(t)')

% 3. naloga
integ = 0;
for n = 1:1:length(t)-1
    h = t(n+1) - t(n);
    trap = h/2 * (P(n)+P(n+1));
    integ = integ + trap;
end

x = trapz(t, P);
fprintf('s for zanko: %f, trapz metoda: %f, razlika: %f\n', integ, x, x-integ);