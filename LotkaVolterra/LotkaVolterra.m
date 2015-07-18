function varargout = LotkaVolterra(varargin)
% LOTKAVOLTERRA MATLAB code for LotkaVolterra.fig
%      LOTKAVOLTERRA, by itself, creates a new LOTKAVOLTERRA or raises the existing
%      singleton*.
%
%      H = LOTKAVOLTERRA returns the handle to a new LOTKAVOLTERRA or the handle to
%      the existing singleton*.
%
%      LOTKAVOLTERRA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOTKAVOLTERRA.M with the given input arguments.
%
%      LOTKAVOLTERRA('Property','Value',...) creates a new LOTKAVOLTERRA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LotkaVolterra_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LotkaVolterra_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LotkaVolterra

% Last Modified by GUIDE v2.5 18-Jul-2015 14:25:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LotkaVolterra_OpeningFcn, ...
                   'gui_OutputFcn',  @LotkaVolterra_OutputFcn, ...
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


% --- Executes just before LotkaVolterra is made visible.
function LotkaVolterra_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LotkaVolterra (see VARARGIN)

% Choose default command line output for LotkaVolterra
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

axes(handles.axes5);
imshow('ModelLV2.png');

% UIWAIT makes LotkaVolterra wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LotkaVolterra_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in modeling.
function modeling_Callback(hObject, eventdata, handles)
% hObject    handle to modeling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


t1 = str2double(get(handles.startInput, 'string'));
t2 = str2double(get(handles.endInput, 'string'));

n = str2double(get(handles.nStart, 'string'));
p = str2double(get(handles.pStart, 'string'));

a = str2double(get(handles.aKoef, 'string'));
b = str2double(get(handles.bKoef, 'string'));
c = str2double(get(handles.cKoef, 'string'));
d = str2double(get(handles.dKoef, 'string'));

perturbKoef = str2double(get(handles.perturbKoef, 'string'));

[times, values] = GenerateMarkovChain(t1, t2);
[timesStep, valuesStep] = StepMarkovData(times, values);
axes(handles.axes4);
plot(timesStep, valuesStep);

j = str2double(get(handles.jKoef, 'string'));

alpha = str2double(get(handles.alpha, 'string'));
axes(handles.axes1);
[tModel,yModel] = ModelLV([t1 t2],[n p],a,b,c,d,j);
[tPerturbedModel,yPerturbedModel] = PeretubedModelLV(times, values, n, p, a,b,c,d,j, perturbKoef);
tPerturbedModel = transpose(tPerturbedModel);
yPerturbedModel = transpose(yPerturbedModel);
plot(tModel, yModel, tPerturbedModel,yPerturbedModel);

[tSAPModel,ySAPModel] = SAP_ModelLV([t1 t2],[n p],a,b,c,d,alpha,j);
[tSAPPModel,ySAPPModel] = SAP_PeretubedModelLV(times, values, n, p,a,b,c,d,alpha,j, perturbKoef);
axes(handles.axes2);

plot(tSAPModel,ySAPModel,tSAPPModel,ySAPPModel);

axes(handles.axes3);

yM1 = squeeze(yModel(:,2));
yM2 = squeeze(yModel(:,1));
yPM1 = squeeze(yPerturbedModel(:,2));
yPM2 = squeeze(yPerturbedModel(:,1));

plot(yM1,yM2, yPM1,yPM2);


%handles.axes1; %Subsequent commands draw on axes1.





function startInput_Callback(hObject, eventdata, handles)
% hObject    handle to startInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.startValue = get(hObject.startInput,'String');
guidata(hObjects,handles);

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



function pStart_Callback(hObject, eventdata, handles)
% hObject    handle to pStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pStart as text
%        str2double(get(hObject,'String')) returns contents of pStart as a double


% --- Executes during object creation, after setting all properties.
function pStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nStart_Callback(hObject, eventdata, handles)
% hObject    handle to nStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nStart as text
%        str2double(get(hObject,'String')) returns contents of nStart as a double


% --- Executes during object creation, after setting all properties.
function nStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1



function aKoef_Callback(hObject, eventdata, handles)
% hObject    handle to aKoef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aKoef as text
%        str2double(get(hObject,'String')) returns contents of aKoef as a double


% --- Executes during object creation, after setting all properties.
function aKoef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aKoef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bKoef_Callback(hObject, eventdata, handles)
% hObject    handle to bKoef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bKoef as text
%        str2double(get(hObject,'String')) returns contents of bKoef as a double


% --- Executes during object creation, after setting all properties.
function bKoef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bKoef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cKoef_Callback(hObject, eventdata, handles)
% hObject    handle to cKoef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cKoef as text
%        str2double(get(hObject,'String')) returns contents of cKoef as a double


% --- Executes during object creation, after setting all properties.
function cKoef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cKoef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dKoef_Callback(hObject, eventdata, handles)
% hObject    handle to dKoef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dKoef as text
%        str2double(get(hObject,'String')) returns contents of dKoef as a double


% --- Executes during object creation, after setting all properties.
function dKoef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dKoef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function jKoef_Callback(hObject, eventdata, handles)
% hObject    handle to jKoef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jKoef as text
%        str2double(get(hObject,'String')) returns contents of jKoef as a double


% --- Executes during object creation, after setting all properties.
function jKoef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jKoef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alpha_Callback(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha as text
%        str2double(get(hObject,'String')) returns contents of alpha as a double


% --- Executes during object creation, after setting all properties.
function alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function perturbKoef_Callback(hObject, eventdata, handles)
% hObject    handle to perturbKoef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of perturbKoef as text
%        str2double(get(hObject,'String')) returns contents of perturbKoef as a double


% --- Executes during object creation, after setting all properties.
function perturbKoef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to perturbKoef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
