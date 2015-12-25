function varargout = twoPhotonAnalysisPreprocess(varargin)
% TWOPHOTONANALYSISPREPROCESS MATLAB code for twoPhotonAnalysisPreprocess.fig
%      TWOPHOTONANALYSISPREPROCESS, by itself, creates a new TWOPHOTONANALYSISPREPROCESS or raises the existing
%      singleton*.
%
%      H = TWOPHOTONANALYSISPREPROCESS returns the handle to a new TWOPHOTONANALYSISPREPROCESS or the handle to
%      the existing singleton*.
%
%      TWOPHOTONANALYSISPREPROCESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWOPHOTONANALYSISPREPROCESS.M with the given input arguments.
%
%      TWOPHOTONANALYSISPREPROCESS('Property','Value',...) creates a new TWOPHOTONANALYSISPREPROCESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before twoPhotonAnalysisPreprocess_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to twoPhotonAnalysisPreprocess_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help twoPhotonAnalysisPreprocess

% Last Modified by GUIDE v2.5 25-Dec-2015 14:16:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @twoPhotonAnalysisPreprocess_OpeningFcn, ...
                   'gui_OutputFcn',  @twoPhotonAnalysisPreprocess_OutputFcn, ...
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


% --- Executes just before twoPhotonAnalysisPreprocess is made visible.
function twoPhotonAnalysisPreprocess_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to twoPhotonAnalysisPreprocess (see VARARGIN)

% Choose default command line output for twoPhotonAnalysisPreprocess
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes twoPhotonAnalysisPreprocess wait for user response (see UIRESUME)
% uiwait(handles.figureTwoPhotonAnalysisPreprocess);


% --- Outputs from this function are returned to the command line.
function varargout = twoPhotonAnalysisPreprocess_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobuttonLocal.
function radiobuttonLocal_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonLocal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonLocal


% --- Executes on button press in radiobuttonCluster.
function radiobuttonCluster_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonCluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonCluster


% --- Executes on button press in pushbuttonAddFile.
function pushbuttonAddFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonAddFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonRemoveFile.
function pushbuttonRemoveFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonRemoveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonStart.
function pushbuttonStart_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkboxEmail.
function checkboxEmail_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxEmail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxEmail
