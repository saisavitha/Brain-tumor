
function varargout = PROJECT(varargin)
% PROJECT M-file for PROJECT.fig
%      PROJECT, by itself, creates a new PROJECT or raises the existing
%      singleton*.
%
%      H = PROJECT returns the handle to a new PROJECT or the handle to
%      the existing singleton*.
%
%      PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT.M with the given input arguments.
%
%      PROJECT('Property','Value',...) creates a new PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PROJECT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PROJECT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PROJECT

% Last Modified by GUIDE v2.5 30-Mar-2013 12:08:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PROJECT_OpeningFcn, ...
                   'gui_OutputFcn',  @PROJECT_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before PROJECT is made visible.
function PROJECT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PROJECT (see VARARGIN)

% Choose default command line output for PROJECT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PROJECT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PROJECT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global bw;
global bw5;
global img_gray;

img_gray=rgb2gray(img);
axes(handles.axes2);
imshow(img_gray);
[r c]=size(img_gray);


b=zeros(r,c);

hp_fil=[-1 2 -1;0 0 0;1 -2 1];
b=imfilter(img_gray,hp_fil);
axes(handles.axes4);
imshow(b);
c=b+img_gray+25;
medfilt2(c);
axes(handles.axes6);
imshow(c); 

T = graythresh(c);
bw = im2bw(c,T+0.3);
axes(handles.axes3);
imshow(bw);


bw5=watershed(bw);
axes(handles.axes5);
imshow(bw5);








% % --- Executes on slider movement.
% function slider1_Callback(hObject, eventdata, handles)
% % hObject    handle to slider1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% 
% 
% % --- Executes during object creation, after setting all properties.
% function slider1_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to slider1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global bw;
global bw5;
global img_gray;
global bw3;

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




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img;
global bw;
global bw5;
global img_gray;
global bw3;

fs = get(0,'ScreenSize');

figure('Position',[round(fs(3)/2) 0 fs(3)/2 fs(4)])

Mat_Image = Matrix_val_Calculation(img_gray);

Difference_Statistic = Prepare_Feature_Set(Mat_Image);

Feature = Extract_Feature_Values(Mat_Image);

Total_Feature_set_Image = [Difference_Statistic Feature];

ASymmetry_Value = Total_Feature_set_Image(9);
set(handles.edit2,'String',ASymmetry_Value);
guidata(hObject, handles);

Contrast_Value = Total_Feature_set_Image(8);
set(handles.edit3,'String',Contrast_Value);
guidata(hObject, handles);

Entropy_Value = Total_Feature_set_Image(7);
set(handles.edit4,'String',Entropy_Value);
guidata(hObject, handles);

IDM_Value = Total_Feature_set_Image(11);
set(handles.edit5,'String',IDM_Value);
guidata(hObject, handles);

Dissm_Value = Total_Feature_set_Image(5);
set(handles.edit6,'String',Dissm_Value);
guidata(hObject, handles);

IP = Total_Feature_set_Image(6);
IP1 = IP/50000;
set(handles.edit7,'String',IP1);
guidata(hObject, handles);

IP2_Value = Total_Feature_set_Image(12);
set(handles.edit8,'String',IP2_Value);
guidata(hObject, handles);

[r2 c2]=size(bw3);

class_norm = 0;
class_cncr = 0;

for i=1:1:r2
    for j=1:1:c2
        if bw3(i,j)==1
            img_gray(i,j)=255;
            class_norm = class_norm + 1;
        else
            img_gray(i,j)=img_gray(i,j)*0.5;
            class_cncr = class_cncr + 1;
        end;
    end;
end;

type_class = [1,2,3,4];

x = type_class;

classes_possible = [1,2,3,4];

t = classes_possible;

net = patternnet(2);

[net,tr] = train(net,x,t);
nntraintool;
plotperform(tr);
testX = x(:,tr.testInd);
testT = t(:,tr.testInd);

testY = net(testX);
testIndices = vec2ind(testY);

if(class_norm <= 600 )
   set(handles.edit1, 'String' ,'ICH DETECTED');
else
   set(handles.edit1, 'String' , 'SDH DETECTED'); 
end
imshow(img);
subplot(2,1,2);
imshow(img_gray);


% --- Executes on slider movement.
%function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% ts=get(handles.slider3,'value');
% global img;
% 
% 
% 
% if (ts==.05)
%     
% img=imread('img1.jpg');
% end
% if (ts== .1)
%     img= imread('img2.jpg')
% end
% if (ts== .15)
%     img= imread('img3.jpg')
% end
% if (ts== .2)
%     img= imread('img4.jpg')
% end
% if (ts== .25)
%     img= imread('img5.jpg')
% end
% if (ts== .3)
%     img= imread('img6.jpg')
% end
% if (ts== .35)
%     img= imread('img7.jpg')
% end
% if (ts== .4)
%     img= imread('img8.jpg')
% end
% if (ts== .45)
%     img= imread('img9.jpg')
% end
% if (ts== .5)
%     img= imread('img10.jpg')
% end
% if (ts== .55)
%     img= imread('img11.jpg')
% end
% if (ts== .6)
%     img= imread('img12.jpg')
% end
% if (ts== .65)
%     img= imread('img13.jpg')
% end
% if (ts== .7)
%     img= imread('img14.jpg')
% end
% if (ts== .75)
%     img= imread('img15.jpg')
% end
% 
% axes(handles.axes1);
% imshow(img);

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.*');
input_image=imread([pathname,filename]);
title('Input Image');
axes(handles.axes1);
imshow(input_image);
handles.input_image = input_image;
guidata(hObject, handles);
img = input_image;
global input_image;
global img;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
% function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes on slider movement.
% function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
