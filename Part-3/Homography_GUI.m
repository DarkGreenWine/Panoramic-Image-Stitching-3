function varargout = Homography_GUI(varargin)
% HOMOGRAPHY_GUI MATLAB code for Homography_GUI.fig
%      HOMOGRAPHY_GUI, by itself, creates a new HOMOGRAPHY_GUI or raises the existing
%      singleton*.
%
%      H = HOMOGRAPHY_GUI returns the handle to a new HOMOGRAPHY_GUI or the handle to
%      the existing singleton*.
%
%      HOMOGRAPHY_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HOMOGRAPHY_GUI.M with the given input arguments.
%
%      HOMOGRAPHY_GUI('Property','Value',...) creates a new HOMOGRAPHY_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Homography_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Homography_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Homography_GUI

% Last Modified by GUIDE v2.5 15-Sep-2019 20:41:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Homography_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Homography_GUI_OutputFcn, ...
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


% --- Executes just before Homography_GUI is made visible.
function Homography_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Homography_GUI (see VARARGIN)

% Choose default command line output for Homography_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Homography_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Homography_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in out1.
function out1_Callback(hObject, eventdata, handles)
% hObject    handle to out1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%   sorry for my bad code
x1 = zeros(4,1);
y1 = zeros(4,1);
x2 = zeros(4,1);
y2 = zeros(4,1);
x1(1) = str2double(get(handles.x11,'String'));
x1(2) = str2double(get(handles.x12,'String'));
x1(3) = str2double(get(handles.x13,'String'));
x1(4) = str2double(get(handles.x14,'String'));
y1(1) = str2double(get(handles.y11,'String'));
y1(2) = str2double(get(handles.y12,'String'));
y1(3) = str2double(get(handles.y13,'String'));
y1(4) = str2double(get(handles.y14,'String'));
x2(1) = str2double(get(handles.x21,'String'));
x2(2) = str2double(get(handles.x22,'String'));
x2(3) = str2double(get(handles.x23,'String'));
x2(4) = str2double(get(handles.x24,'String'));
y2(1) = str2double(get(handles.y21,'String'));
y2(2) = str2double(get(handles.y22,'String'));
y2(3) = str2double(get(handles.y23,'String'));
y2(4) = str2double(get(handles.y24,'String'));
% Construct A matrix
A = zeros(8,9);
for i = 1:4
    A(2*i-1:2*i,:) = [x1(i) y1(i) 1 0 0 0 -x1(i)*x2(i) -x2(i)*y1(i) -x2(i);
                    0 0 0 x1(i) y1(i) 1 -y2(i)*x1(i) -y2(i)*y1(i) -y2(i)];
end
[~,~,V] = svd(A);
p = V(:,9);
h = reshape(p,3,3)/p(9);
h(1:2,3) = 0;
axes(handles.axes3);
tform = affine2d(h);
J = imwarp(handles.image1,tform);
imshow(J)
axis on


function x11_Callback(hObject, eventdata, handles)
% hObject    handle to x11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x11 as text
%        str2double(get(hObject,'String')) returns contents of x11 as a double


% --- Executes during object creation, after setting all properties.
function x11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y11_Callback(hObject, eventdata, handles)
% hObject    handle to y11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y11 as text
%        str2double(get(hObject,'String')) returns contents of y11 as a double


% --- Executes during object creation, after setting all properties.
function y11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x12_Callback(hObject, eventdata, handles)
% hObject    handle to x12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x12 as text
%        str2double(get(hObject,'String')) returns contents of x12 as a double


% --- Executes during object creation, after setting all properties.
function x12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x13_Callback(hObject, eventdata, handles)
% hObject    handle to x13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x13 as text
%        str2double(get(hObject,'String')) returns contents of x13 as a double


% --- Executes during object creation, after setting all properties.
function x13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y13_Callback(hObject, eventdata, handles)
% hObject    handle to y13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y13 as text
%        str2double(get(hObject,'String')) returns contents of y13 as a double


% --- Executes during object creation, after setting all properties.
function y13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x14_Callback(hObject, eventdata, handles)
% hObject    handle to x14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x14 as text
%        str2double(get(hObject,'String')) returns contents of x14 as a double


% --- Executes during object creation, after setting all properties.
function x14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y12_Callback(hObject, eventdata, handles)
% hObject    handle to y12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y12 as text
%        str2double(get(hObject,'String')) returns contents of y12 as a double


% --- Executes during object creation, after setting all properties.
function y12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y14_Callback(hObject, eventdata, handles)
% hObject    handle to y14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y14 as text
%        str2double(get(hObject,'String')) returns contents of y14 as a double


% --- Executes during object creation, after setting all properties.
function y14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cs1.
function cs1_Callback(hObject, eventdata, handles)
% hObject    handle to cs1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
[x,y] = ginput(4);
set(handles.x11,'String',x(1));
set(handles.x12,'String',x(2));
set(handles.x13,'String',x(3));
set(handles.x14,'String',x(4));
set(handles.y11,'String',y(1));
set(handles.y12,'String',y(2));
set(handles.y13,'String',y(3));
set(handles.y14,'String',y(4));

function x21_Callback(hObject, eventdata, handles)
% hObject    handle to x21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x21 as text
%        str2double(get(hObject,'String')) returns contents of x21 as a double


% --- Executes during object creation, after setting all properties.
function x21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y21_Callback(hObject, eventdata, handles)
% hObject    handle to y21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y21 as text
%        str2double(get(hObject,'String')) returns contents of y21 as a double


% --- Executes during object creation, after setting all properties.
function y21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x22_Callback(hObject, eventdata, handles)
% hObject    handle to x22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x22 as text
%        str2double(get(hObject,'String')) returns contents of x22 as a double


% --- Executes during object creation, after setting all properties.
function x22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x23_Callback(hObject, eventdata, handles)
% hObject    handle to x23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x23 as text
%        str2double(get(hObject,'String')) returns contents of x23 as a double


% --- Executes during object creation, after setting all properties.
function x23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y23_Callback(hObject, eventdata, handles)
% hObject    handle to y23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y23 as text
%        str2double(get(hObject,'String')) returns contents of y23 as a double


% --- Executes during object creation, after setting all properties.
function y23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x24_Callback(hObject, eventdata, handles)
% hObject    handle to x24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x24 as text
%        str2double(get(hObject,'String')) returns contents of x24 as a double


% --- Executes during object creation, after setting all properties.
function x24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y22_Callback(hObject, eventdata, handles)
% hObject    handle to y22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y22 as text
%        str2double(get(hObject,'String')) returns contents of y22 as a double


% --- Executes during object creation, after setting all properties.
function y22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y24_Callback(hObject, eventdata, handles)
% hObject    handle to y24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y24 as text
%        str2double(get(hObject,'String')) returns contents of y24 as a double


% --- Executes during object creation, after setting all properties.
function y24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cs2.
function cs2_Callback(hObject, eventdata, handles)
% hObject    handle to cs2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
[x,y] = ginput(4);
set(handles.x21,'String',x(1));
set(handles.x22,'String',x(2));
set(handles.x23,'String',x(3));
set(handles.x24,'String',x(4));
set(handles.y21,'String',y(1));
set(handles.y22,'String',y(2));
set(handles.y23,'String',y(3));
set(handles.y24,'String',y(4));

% --- Executes on button press in show1.
function show1_Callback(hObject, eventdata, handles)
% hObject    handle to show1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image1 = imread(get(handles.edit1,'String'));
handles.image1 = image1;
guidata(hObject,handles)
axes(handles.axes1);
imshow(handles.image1);
axis on

% --- Executes on button press in show2.
function show2_Callback(hObject, eventdata, handles)
% hObject    handle to show2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image2 = imread(get(handles.edit2,'String'));
handles.image2 = image2;
guidata(hObject,handles)
axes(handles.axes2);
imshow(handles.image2);
axis on


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3
