function varargout = twoPhotonAnalysisPrefs(varargin)
% TWOPHOTONANALYSISPREFS MATLAB code for twoPhotonAnalysisPrefs.fig
%      TWOPHOTONANALYSISPREFS, by itself, creates a new TWOPHOTONANALYSISPREFS or raises the existing
%      singleton*.
%
%      H = TWOPHOTONANALYSISPREFS returns the handle to a new TWOPHOTONANALYSISPREFS or the handle to
%      the existing singleton*.
%
%      TWOPHOTONANALYSISPREFS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWOPHOTONANALYSISPREFS.M with the given input arguments.
%
%      TWOPHOTONANALYSISPREFS('Property','Value',...) creates a new TWOPHOTONANALYSISPREFS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before twoPhotonAnalysisPrefs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to twoPhotonAnalysisPrefs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help twoPhotonAnalysisPrefs

% Last Modified by GUIDE v2.5 25-Dec-2015 14:03:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @twoPhotonAnalysisPrefs_OpeningFcn, ...
                   'gui_OutputFcn',  @twoPhotonAnalysisPrefs_OutputFcn, ...
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


% --- Executes just before twoPhotonAnalysisPrefs is made visible.
function twoPhotonAnalysisPrefs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to twoPhotonAnalysisPrefs (see VARARGIN)

% Choose default command line output for twoPhotonAnalysisPrefs
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes twoPhotonAnalysisPrefs wait for user response (see UIRESUME)
% uiwait(handles.figureTwoPhotonAnalysisPrefs);


% --- Outputs from this function are returned to the command line.
function varargout = twoPhotonAnalysisPrefs_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editEmail_Callback(hObject, eventdata, handles)
% hObject    handle to editEmail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEmail as text
%        str2double(get(hObject,'String')) returns contents of editEmail as a double


% --- Executes during object creation, after setting all properties.
function editEmail_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEmail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editUsername_Callback(hObject, eventdata, handles)
% hObject    handle to editUsername (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editUsername as text
%        str2double(get(hObject,'String')) returns contents of editUsername as a double


% --- Executes during object creation, after setting all properties.
function editUsername_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editUsername (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxHoverZoom.
function checkboxHoverZoom_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxHoverZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxHoverZoom


% --- Executes on button press in checkboxSaveLocal.
function checkboxSaveLocal_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxSaveLocal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxSaveLocal



function editLocalBackupLocation_Callback(hObject, eventdata, handles)
% hObject    handle to editLocalBackupLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLocalBackupLocation as text
%        str2double(get(hObject,'String')) returns contents of editLocalBackupLocation as a double


% --- Executes during object creation, after setting all properties.
function editLocalBackupLocation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLocalBackupLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonLocalBackupLocation.
function pushbuttonLocalBackupLocation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonLocalBackupLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuFileNew_Callback(hObject, eventdata, handles)
% hObject    handle to menuFileNew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuFileOpen_Callback(hObject, eventdata, handles)
% hObject    handle to menuFileOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuFileSave_Callback(hObject, eventdata, handles)
% hObject    handle to menuFileSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuFileExit_Callback(hObject, eventdata, handles)
% hObject    handle to menuFileExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
