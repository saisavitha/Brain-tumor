img = imread('img1.jpg');

img_gray=rgb2gray(img);
imshow(img_gray);
[r c]=size(img_gray);
b=zeros(r,c);
hp_fil=[-1 2 -1;0 0 0;1 -2 1];
b=imfilter(img_gray,hp_fil);
figure;
imshow(b);
c=b+img_gray+25;
medfilt2(c);
figure;
imshow(c); 
T = graythresh(c);
bw = im2bw(c,T+0.3);
figure;
imshow(bw);
bw5=watershed(bw);
figure;
imshow(bw5);
fs = get(0,'ScreenSize');
figure('Position',[0 0 fs(3)/2 fs(4)])
SE = strel('disk',0);
 
bw1 = imerode(bw,SE);
subplot(3,2,1);
imshow(bw1);
            

SE = strel('disk',0);
bw1 = imdilate(bw1,SE);
subplot(3,2,2);
imshow(bw1);



SE2 = strel('disk',1);
bw2 = imerode(bw1,SE2);
subplot(3,2,3);
imshow(bw2)
             
SE2 = strel('disk',1);
bw2 = imdilate(bw2,SE2);
subplot(3,2,4);
imshow(bw2)

SE3 = strel('disk',6);
bw3 = imerode(bw2,SE3);
subplot(3,2,5);
imshow(bw3)
             
SE3 = strel('disk',6);
bw3 = imdilate(bw3,SE3);
subplot(3,2,6);
imshow(bw3)

fs = get(0,'ScreenSize');
figure('Position',[round(fs(3)/2) 0 fs(3)/2 fs(4)])

[r2 c2]=size(bw3);

for i=1:1:r2
    for j=1:1:c2
        if bw3(i,j)==1
            img_gray(i,j)=255;
        else
            img_gray(i,j)=img_gray(i,j)*0.5;
        end;
    end;
end;
subplot(2,1,1);
imshow(img);
subplot(2,1,2);
imshow(img_gray);


SE3 = strel('disk',6);
bw3 = imerode(bw2,SE3);
subplot(3,2,5);
imshow(bw3)
             
SE3 = strel('disk',6);
bw3 = imdilate(bw3,SE3);
subplot(3,2,6);
imshow(bw3)