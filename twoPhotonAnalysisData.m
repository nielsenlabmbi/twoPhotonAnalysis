function varargout = twoPhotonAnalysisData(varargin)
% TWOPHOTONANALYSISDATA MATLAB code for twoPhotonAnalysisData.fig
%      TWOPHOTONANALYSISDATA, by itself, creates a new TWOPHOTONANALYSISDATA or raises the existing
%      singleton*.
%
%      H = TWOPHOTONANALYSISDATA returns the handle to a new TWOPHOTONANALYSISDATA or the handle to
%      the existing singleton*.
%
%      TWOPHOTONANALYSISDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWOPHOTONANALYSISDATA.M with the given input arguments.
%
%      TWOPHOTONANALYSISDATA('Property','Value',...) creates a new TWOPHOTONANALYSISDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before twoPhotonAnalysisData_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to twoPhotonAnalysisData_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help twoPhotonAnalysisData

% Last Modified by GUIDE v2.5 25-Dec-2015 14:18:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @twoPhotonAnalysisData_OpeningFcn, ...
                   'gui_OutputFcn',  @twoPhotonAnalysisData_OutputFcn, ...
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


% --- Executes just before twoPhotonAnalysisData is made visible.
function twoPhotonAnalysisData_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to twoPhotonAnalysisData (see VARARGIN)

% Choose default command line output for twoPhotonAnalysisData
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes twoPhotonAnalysisData wait for user response (see UIRESUME)
% uiwait(handles.figureTwoPhotonAnalysisData);


% --- Outputs from this function are returned to the command line.
function varargout = twoPhotonAnalysisData_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
