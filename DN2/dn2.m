clc;clear all;

data = readmatrix('vozlisca_temperature_dn2_21.txt', 'NumHeaderLines', 4);

x = data(:,1);
y = data(:,2);
T = data(:,3);

x_target = 0.403;
y_target = 0.503;

% Z uporabo scateredInterpolant
tic;
T_scat = scatteredInterpolant(x, y, T, 'linear', 'none');
t_scat = toc;

fprintf('Z uporabo scateredInterpolant: %f, čas: %f\n', ...
    T_scat(x_target, y_target), t_scat);

% Z uporabo griddedInterpolant
tic;
x_unique = unique(x);
y_unique = unique(y);
Tmat = reshape(T, 1481, 961); t_grid_prepare = toc; tic;
T_grid = griddedInterpolant({x_unique, y_unique}, Tmat,"linear","none");
t_grid_func = toc;

t_grid = t_grid_prepare + t_grid_func;

fprintf('Z uporabo griddedInterpolant: %f, čas: %f\n', ...
    T_grid(x_target, y_target), t_grid);

% Z uporabo lastne interpolacije
cells = readmatrix('celice_dn2_21.txt', 'NumHeaderLines', 2);


tic
for i=1:size(cells,1)
    pt = cells(i, :);

    pt1 = pt(1);
    pt2 = pt(2);
    pt3 = pt(3);
    pt4 = pt(4);

    x1 = x(pt1);
    x2 = x(pt2);
    x3 = x(pt3);
    x4 = x(pt4);

    y1 = y(pt1);
    y2 = y(pt2);
    y3 = y(pt3);
    y4 = y(pt4);

    xv = [x1 x2 x3 x4];
    yv = [y1 y2 y3 y4];

    [in, on] = inpolygon(x_target, y_target, xv, yv);

    if in || on
        break;
    end
end

K1 = (x2-x_target)/(x2-x1)*T(pt1) + (x_target-x1)/(x2-x1)*T(pt2);
K2 = (x2-x_target)/(x2-x1)*T(pt4) + (x_target-x1)/(x2-x1)*T(pt3);

T_man = (y3-y_target)/(y3-y2)*K1 + (y_target-y2)/(y3-y2)*K2;
t_man = toc;

fprintf('Z uporabo lastne interpolacije: %f, čas: %f\n\n', T_man, t_man);

[maxTemp, index] = max(T);

fprintf('Najvišja temperatura: %f, x = %f, y = %f\n', ...
    maxTemp, x(index), y(index));

