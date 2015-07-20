function varargout = sopApp(varargin)
% SOPAPP MATLAB code for sopApp.fig
%      SOPAPP, by itself, creates a new SOPAPP or raises the existing
%      singleton*.
%
%      H = SOPAPP returns the handle to a new SOPAPP or the handle to
%      the existing singleton*.
%
%      SOPAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOPAPP.M with the given input arguments.
%
%      SOPAPP('Property','Value',...) creates a new SOPAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sopApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sopApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sopApp

% Last Modified by GUIDE v2.5 21-Jul-2015 00:39:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sopApp_OpeningFcn, ...
                   'gui_OutputFcn',  @sopApp_OutputFcn, ...
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


% --- Executes just before sopApp is made visible.
function sopApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sopApp (see VARARGIN)

% Choose default command line output for sopApp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sopApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sopApp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function startInput_Callback(hObject, eventdata, handles)
% hObject    handle to startInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startInput as text
%        str2double(get(hObject,'String')) returns contents of startInput as a double


% --- Executes during object creation, after setting all properties.
function startInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in modelling.
function modelling_Callback(hObject, eventdata, handles)
% hObject    handle to modelling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

t1 = str2double(get(handles.startInput, 'string'));
t2 = str2double(get(handles.endInput, 'string'));

a = str2double(get(handles.aSOP, 'string'));
b = str2double(get(handles.bSOP, 'string'));
u0 = str2double(get(handles.uStart, 'string'));


[t, y] = GenerateMarkovChain(t1,t2);

[tStep, yStep] = StepMarkovData(t, y);

[tSOP, ySOP] = SolveSOP(t, y, a, b, u0);

axes(handles.axes3);

fh = @(u) u^2;
fplot(fh,[0,500]);


axes(handles.axes1);
plot(tStep, yStep);

axes(handles.axes2);
plot(tSOP, ySOP);


function endInput_Callback(hObject, eventdata, handles)
% hObject    handle to endInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endInput as text
%        str2double(get(hObject,'String')) returns contents of endInput as a double


% --- Executes during object creation, after setting all properties.
function endInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aSOP_Callback(hObject, eventdata, handles)
% hObject    handle to aSOP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aSOP as text
%        str2double(get(hObject,'String')) returns contents of aSOP as a double


% --- Executes during object creation, after setting all properties.
function aSOP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aSOP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bSOP_Callback(hObject, eventdata, handles)
% hObject    handle to bSOP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bSOP as text
%        str2double(get(hObject,'String')) returns contents of bSOP as a double


% --- Executes during object creation, after setting all properties.
function bSOP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bSOP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function uStart_Callback(hObject, eventdata, handles)
% hObject    handle to uStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of uStart as text
%        str2double(get(hObject,'String')) returns contents of uStart as a double


% --- Executes during object creation, after setting all properties.
function uStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
