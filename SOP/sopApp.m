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

% Last Modified by GUIDE v2.5 06-Aug-2015 19:57:33

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

extremeRadio = get(get(handles.extremumType, 'SelectedObject'),'tag');

isMin = strcmp(extremeRadio, 'minRadio');

states = str2num(get(handles.states, 'string'));

index_selected = get(handles.functionsList, 'Value');
list = get(handles.functionsList,'String');
regFunc = list{index_selected};

if index_selected == 3
    psoFunc = strrep(regFunc, 'a_m', get(handles.a_m, 'string'));
    psoFunc = strrep(psoFunc, 'b_m', get(handles.b_m, 'string'));
    func = strrep(psoFunc, 'u', num2str(u0));
end


[t, y] = GenerateMarkovChain(t1,t2, states);

[tStep, yStep] = StepMarkovData(t, y);

[tFunc, uFunc] = GetFunction(func, t, y,index_selected);

[tSOP, ySOP, ttSOP, yySOP] = SolveSOP(psoFunc, t, y, a, b, u0, isMin);

axes(handles.axes1);
plot(tStep, yStep);

axes(handles.axes2);
plot(tSOP, ySOP);
%plot(ttSOP, yySOP);

set(handles.txtExtremum, 'string', ySOP(1, end));

axes(handles.axes4);
%plot(ttSOP, yySOP);
plot(tFunc, uFunc);
%sn = @(x) sin(1./x);
%fplot(sn,[0.01,0.1])


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


% --- Executes on button press in maxRadio.
function maxRadio_Callback(hObject, eventdata, handles)
% hObject    handle to maxRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of maxRadio


% --- Executes on button press in minRadio.
function minRadio_Callback(hObject, eventdata, handles)
% hObject    handle to minRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of minRadio


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


% --- Executes on selection change in functionsList.
function functionsList_Callback(hObject, eventdata, handles)
index = get(hObject, 'Value');
if index == 3
    set(handles.testModel, 'Visible', 'on');
else
    set(handles.testModel, 'Visible', 'off');
end
% hObject    handle to functionsList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns functionsList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from functionsList


% --- Executes during object creation, after setting all properties.
function functionsList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to functionsList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function states_Callback(hObject, eventdata, handles)
% hObject    handle to states (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of states as text
%        str2double(get(hObject,'String')) returns contents of states as a double


% --- Executes during object creation, after setting all properties.
function states_CreateFcn(hObject, eventdata, handles)
% hObject    handle to states (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_m_Callback(hObject, eventdata, handles)
% hObject    handle to a_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_m as text
%        str2double(get(hObject,'String')) returns contents of a_m as a double


% --- Executes during object creation, after setting all properties.
function a_m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_m_Callback(hObject, eventdata, handles)
% hObject    handle to b_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b_m as text
%        str2double(get(hObject,'String')) returns contents of b_m as a double


% --- Executes during object creation, after setting all properties.
function b_m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
