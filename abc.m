function varargout = abc(varargin)
% ABC MATLAB code for abc.fig
%      ABC, by itself, creates a new ABC or raises the existing
%      singleton*.
%
%      H = ABC returns the handle to a new ABC or the handle to
%      the existing singleton*.
%
%      ABC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABC.M with the given input arguments.
%
%      ABC('Property','Value',...) creates a new ABC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before abc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to abc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help abc

% Last Modified by GUIDE v2.5 08-Aug-2018 22:23:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @abc_OpeningFcn, ...
                   'gui_OutputFcn',  @abc_OutputFcn, ...
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


% --- Executes just before abc is made visible.
function abc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to abc (see VARARGIN)

% Choose default command line output for abc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes abc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = abc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_image.
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im2
[path,user_cancel]=imgetfile();

if user_cancel
    msgbox(sprintf('Invalid Selection'),'Error','Error');
    return
end
im=imread(path);
im=im2double(im);
im2=im;
axes(handles.axes1);
imshow(im);
title('\fontsize{20}\color[rgb]{0.635 0.078 0.184} Patient''s brain');

% --- Executes on button press in detect.
function detect_Callback(hObject, eventdata, handles)
% hObject    handle to detect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im
axes(handles.axes2);

bw=im2bw(im, 0.7);
label=bwlabel(bw);


stats=regionprops(label,'Solidity','Area');

density=[stats.Solidity];
area=[stats.Area];

high_density_area=density>0.5;

max_area= max(area(high_density_area));
tumor_label=find(area == max_area);
tumor=ismember(label,tumor_label);

se=strel('square',5);
tumor=imdilate(tumor,se);




[B,L]=bwboundaries(tumor,'noholes');
imshow(im,[]);
hold on
for i=1:length(B)
    plot(B{i}(:,2),B{i}(:,1),'y','linewidth',1.45);
end

title('\fontsize{20}\color[rgb]{0.635 0.078 0.184} Detected Tumors');
hold off;



% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function author_Callback(hObject, eventdata, handles)
% hObject    handle to author (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox(sprintf('Name: Jeel Sukhadiya \n email:jeelsukhadiya2@gmail.com \n phoneno:9029272001'),'Author','Help');
