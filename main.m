clc
clear

%% read in data
fid = fopen('foret.dat');
data = fread(fid, Inf, 'float32');
fclose(fid);
X = data(1:4:end);
Y = data(2:4:end);
Z = data(3:4:end);
A = data(4:4:end);
%% projection of points and regional average
figure
% plot3(X(:),Y(:),Z), axis equal, axis vis3d, colormap(gray);
scatter3(X(:),Y(:),Z(:),10,Z,'.'),colormap(gray);

min_x = floor(min(X));
max_x = floor(max(X));
min_y = floor(min(Y));
max_y = floor(max(Y));
num_z = zeros(max_x-min_x+1, max_y-min_y+1);
sum_z = zeros(max_x-min_x+1, max_y-min_y+1);
avg_z = zeros(max_x-min_x+1, max_y-min_y+1);
for i = 1:size(X,1)
    num_z(floor(X(i))-min_x+1, floor(Y(i))-min_y+1) = num_z(floor(X(i))-min_x+1, floor(Y(i))-min_y+1) + 1;
    sum_z(floor(X(i))-min_x+1, floor(Y(i))-min_y+1) = sum_z(floor(X(i))-min_x+1, floor(Y(i))-min_y+1) + Z(i);
end
for i = 1:size(avg_z, 1)
    for j = 1:size(avg_z, 2)
        if num_z(i,j) ~= 0
            avg_z(i, j) = sum_z(i, j) / num_z(i, j);           
        end        
    end
end
[z_min,ind] = min(min(avg_z(find(avg_z~=0))));
[z_max,ind] = max(max(avg_z(find(avg_z))));
figure
imshow(avg_z,[z_min, z_max]),colormap(gray);

