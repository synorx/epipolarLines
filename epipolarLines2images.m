% This code was written by Alperen Düzen 
% as part of the Introduction to Digital Photogrammetry course.
%% Read images and load Fundamental Matrix
img1=imread('../images/im1.jpg');
img2=imread('../images/im2.jpg');
load('Fmatrix.mat');

%% 5 point selection on image2
imshow(img2);
uiwait(msgbox('Please choose points')); 
n = 5;
pixel_c=[];
for k = 1:n
  [x,y] = ginput(1); hold on;
  plot(x,y,'b+', 'MarkerSize', 14);
  pixel_c(k,:)=[x,y,1];  %
end
uiwait(msgbox('Thanks your choose'));
close gcf
%% Size of image 1 and relation matrix with compute border lines
lines2=pixel_c*F; % for im1


[row,col]=size(lines2); 
[ymax,xmax]=size(img1(:,:,1));

border_lines=[]; %% im1 border lines matrix
border_lines2=[]; %%im2 border lines matrix

%% Foor loop which add border lines to img1 and img2 related to choosen points on image2
 for i=1:row
     x=lines2(i,3)/-lines2(i,1);
     y=lines2(i,3)/-lines2(i,2);
     m=-y/x ; % im1 curves
     m2=(pixel_c(i,2)-y)/(xmax-pixel_c(i,1)); %im2  curves
     
     if (0 < x) &&  (x < xmax) && (y > ymax) || (0 < x) &&  (x < xmax) && (y < 0)
         line_x=x- ymax/m;
         border_lines(i,:)=[x 0 line_x ymax];
         
         
     elseif (0 < y) && (y < ymax) && (x > xmax)  || (0 < y) && (y < ymax) && (x < 0) 
     line_y=(xmax)*m + y;
     border_lines(i,:)=[0 y xmax line_y];
     img2_line_y=xmax*m2 + y;
     border_lines2(i,:)=[0 img2_line_y  xmax y];
     
     
     elseif 0 < x &&  x < xmax && 0 < y && y < ymax
         line_x=(ymax-y)/m;
         border_lines(i,:)=[0 y line_x ymax];
         
     elseif (x > xmax) && (y > ymax)
         line_y=(xmax)*m+y;
         border_lines(i,:)=[x 0 xmax line_y];
    
     end
       
 end
%% display border lines on two images

figure;
stackedImage = cat(2, img2, img1); % Places the two images side by side
imshow(stackedImage);
title('Epipolar Lines on Images'); 
line(border_lines(:,[1,3])'+768,border_lines(:,[2,4])'); hold on;
line(border_lines2(:,[1,3])',border_lines2(:,[2,4])'); hold on;

for i=1:row
plot(pixel_c(i,1),pixel_c(i,2),'.b','MarkerSize',10); hold on;
end











