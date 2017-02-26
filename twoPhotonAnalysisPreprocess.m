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

    % Last Modified by GUIDE v2.5 03-Jan-2016 23:13:42

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
function twoPhotonAnalysisPreprocess_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<INUSL>
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
    refreshFileList(handles);

% --- Outputs from this function are returned to the command line.
function varargout = twoPhotonAnalysisPreprocess_OutputFcn(hObject, eventdata, handles)  %#ok<INUSL>
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;


% --- Executes on button press in radiobuttonLocal.
function radiobuttonLocal_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
    % hObject    handle to radiobuttonLocal (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of radiobuttonLocal


% --- Executes on button press in radiobuttonCluster.
function radiobuttonCluster_Callback(hObject, eventdata, handles)  %#ok<INUSD,DEFNU>
    % hObject    handle to radiobuttonCluster (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of radiobuttonCluster


% --- Executes on button press in pushbuttonAddFile.
function pushbuttonAddFile_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
    % hObject    handle to pushbuttonAddFile (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    load('settings/currentSettings.mat');
    [rawFullPath.fullExpt,rawFullPath.path] = uigetfile('*.sbx', 'Pick a raw file (sbx)','MultiSelect', 'on');
    
    if ~isequal(rawFullPath.fullExpt,0) && ~isequal(rawFullPath.path,0)
        rawFullPath.fullExpt = rawFullPath.fullExpt(1:strfind(rawFullPath.fullExpt,'.sbx')-1);
        rawFullPath.fullPath = fullfile(rawFullPath.path,rawFullPath.fullExpt);
        [rawFullPath.animal,rawFullPath.unit,rawFullPath.expt] = splitDelimitedExpt(rawFullPath.fullExpt);
       
        if ~exist([rawFullPath.fullPath '.mat'],'file')
            errordlg('The info file does not exist in the same directory.','File not found');
            return;
        elseif setting.requireAnalyzer
            if ~exist([rawFullPath.path rawFullPath.animal '_u' rawFullPath.unit '_' rawFullPath.expt '.Analyzer'],'file')
                errordlg('The analyzer file does not exist in the same directory.','File not found');
                return;
            else
                load([rawFullPath.path rawFullPath.animal '_u' rawFullPath.unit '_' rawFullPath.expt '.Analyzer'],'-mat');
                analyzer = Analyzer; %#ok<NASGU>
                if setting.doSaveAtSbx
                    save([rawFullPath.path rawFullPath.animal '_' rawFullPath.unit '_' rawFullPath.expt '_analyzer.mat'],'analyzer');
                end
                if setting.doSaveLocal
                    save([setting.localSaveLocation rawFullPath.animal '_' rawFullPath.unit '_' rawFullPath.expt '_analyzer.mat'],'analyzer');
                end
            end
        end
        fileList = getFileListToProcess();
        if isempty(fileList)
            fileList = struct(rawFullPath);
        else
            fileList(length(fileList)+1) = rawFullPath;
        end
        setFileListToProcess(fileList);
        refreshFileList(handles);
    end
    
    
function [animal,unit,expt] = splitDelimitedExpt(fullExpt)
    values 	= textscan(fullExpt, '%s%s%s', 'delimiter', '_');
    animal 	= values{1}{1};
	unit 	= values{2}{1};
    expt    = values{3}{1};
    

% --- Executes on button press in pushbuttonRemoveFile.
function pushbuttonRemoveFile_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
    % hObject    handle to pushbuttonRemoveFile (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    global selectedCell; % Global; Bah. #TODO: GET RID OF THIS!
    if isempty(selectedCell)
        set(handles.textStatus,'string','Select a file to select.');
    else
        fileList = getFileListToProcess();
        fileList(selectedCell) = [];
        setFileListToProcess(fileList);
        selectedCell = [];
        refreshFileList(handles);
    end
    

% --- Executes on button press in pushbuttonStart.
function pushbuttonStart_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
    % hObject    handle to pushbuttonStart (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    if get(handles.radiobuttonLocal,'value')
        fileList = getFileListToProcess();
        [acks,preprocessedData] = batchPreprocessLocal(fileList);
        formatAndSavePreprocessedStructure(preprocessedData);
    else
        errordlg('Cluster computing is not available in this release.','Cluster config not set');
        return;
    end
    isError = 0;
    msg = cell(1,length(fileList));
    for ii=1:length(fileList)
        if ack(ii).isDone
            fileList(ii) = [];
        else
            isError = 1;
        end
        msg{ii} = ack(ii).msg;
    end
    if get(handles.checkboxEmail,'value',1)
        if isError
            emailCurrentUser(emailTypes.preprocessError,acks);
        else
            emailCurrentUser(emailTypes.preprocessComplete,acks);
        end
    end
    refreshFileList(handles);
    
function formatAndSavePreprocessedStructure(preprocessedData)

    
% --- Executes on button press in checkboxEmail.
function checkboxEmail_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to checkboxEmail (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of checkboxEmail

function refreshFileList(handles)
    fileList = getFileListToProcess();
    tableStr = cell(length(fileList),2);
    for ii=1:length(fileList)
        tableStr(ii,:) = {fileList(ii).fullExpt fileList(ii).path};
    end
    set(handles.uitableFileList,'data',tableStr);
    

function fileList = getFileListToProcess()
    load('settings/currentSettings.mat');
    fileList = struct([]);
    if setting.doSaveLocal
        localInputTempFile = [setting.localSaveLocation '/preprocessInputsTemp.mat'];
    elseif exist('localTempLocationForDataSave','dir')
        localInputTempFile = 'localTempLocationForDataSave/preprocessInputsTemp.mat';
    else
        mkdir('localTempLocationForDataSave');
        localInputTempFile = 'localTempLocationForDataSave/preprocessInputsTemp.mat';
    end
    if exist(localInputTempFile,'file')
        load(localInputTempFile);
    end
    
function setFileListToProcess(fileList) %#ok<INUSD>
    load('settings/currentSettings.mat');
    if setting.doSaveLocal
        localInputTempFile = [setting.localSaveLocation '/preprocessInputsTemp.mat'];
    elseif exist('localTempLocationForDataSave','dir')
        localInputTempFile = 'localTempLocationForDataSave/preprocessInputsTemp.mat';
    else
        mkdir('localTempLocationForDataSave');
        localInputTempFile = 'localTempLocationForDataSave/preprocessInputsTemp.mat';
    end
    save(localInputTempFile,'fileList');


% --- Executes when selected cell(s) is changed in uitableFileList.
function uitableFileList_CellSelectionCallback(hObject, eventdata, handles)  %#ok<INUSL,DEFNU,INUSD>
    % hObject    handle to uitableFileList (see GCBO)
    % eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
    %	Indices: row and column indices of the cell(s) currently selecteds
    % handles    structure with handles and user data (see GUIDATA)

    % this is the only bloody way of getting the selected cell. I hate matlab.
    global selectedCell; % #TODO: GET RID OF THIS!
    if ~isempty(eventdata.Indices)
        selectedCell = eventdata.Indices(1);
    end