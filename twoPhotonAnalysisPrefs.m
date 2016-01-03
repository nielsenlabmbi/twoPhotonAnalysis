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

    % Last Modified by GUIDE v2.5 31-Dec-2015 09:04:16

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
function twoPhotonAnalysisPrefs_OpeningFcn(hObject,eventdata, handles, varargin) %#ok<INUSL>
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
    if ~exist('settings','dir');                      mkdir('settings');                 end
    if ~exist('settings/currentSettings.mat','file'); makeDefaultSettingsFiles(handles); end

    load('settings/currentSettings.mat');
    fillFields(setting,handles);
    
    if ~isempty(setting.localSaveLocation) && ~exist(setting.localSaveLocation,'dir')
        mkdir(setting.localSaveLocation); 
    end
    

function makeDefaultSettingsFiles(handles)
    setting.uName = 'admin';
    setting.email = 'nielsenlabmbi@gmail.com';
    setting.doHoverZoom = 1; 
    setting.doSaveLocal = 1; 
    setting.doSaveAtSbx = 1; 
    setting.requireAnalyzer = 1; 
    setting.localSaveLocation = 'localProcessedData';
    save(['settings/' setting.uName '.mat'],'setting');
    save('settings/currentSettings.mat','setting');
    set(handles.textStatus,'string','Created default settings');

    
function fillFields(setting,handles)
    set(handles.editUsername,'string',setting.uName);
    set(handles.editEmail,'string',setting.email);
    set(handles.editLocalLocation,'string',setting.localSaveLocation);
    set(handles.checkboxHoverZoom,'Value',setting.doHoverZoom);
    set(handles.checkboxSaveLocal,'Value',setting.doSaveLocal);
    set(handles.checkboxSaveAtSbx,'Value',setting.doSaveAtSbx);
    set(handles.checkboxRequireAnalyzer,'Value',setting.requireAnalyzer);
    if ~setting.doSaveLocal
        set(handles.editLocalLocation,'Enable','off');
        set(handles.pushbuttonLocalLocation,'Enable','off');
    else
        set(handles.editLocalLocation,'Enable','on');
        set(handles.pushbuttonLocalLocation,'Enable','on');
    end
    set(handles.textStatus,'string',['Loaded settings for ' setting.uName]);

    
% --- Outputs from this function are returned to the command line.
function varargout = twoPhotonAnalysisPrefs_OutputFcn(hObject, eventdata, handles)  %#ok<INUSL>
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;

    
function editEmail_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to editEmail (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editEmail as text
    %        str2double(get(hObject,'String')) returns contents of editEmail as a double


% --- Executes during object creation, after setting all properties.
function editEmail_CreateFcn(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to editEmail (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end



function editUsername_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to editUsername (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editUsername as text
    %        str2double(get(hObject,'String')) returns contents of editUsername as a double


% --- Executes during object creation, after setting all properties.
function editUsername_CreateFcn(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to editUsername (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in checkboxHoverZoom.
function checkboxHoverZoom_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to checkboxHoverZoom (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of checkboxHoverZoom


% --- Executes on button press in checkboxSaveLocal.
function checkboxSaveLocal_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
    % hObject    handle to checkboxSaveLocal (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of checkboxSaveLocal
    if ~get(hObject,'Value')
        set(handles.editLocalLocation,'Enable','off');
        set(handles.pushbuttonLocalLocation,'Enable','off');
    else
        set(handles.editLocalLocation,'Enable','on');
        set(handles.pushbuttonLocalLocation,'Enable','on');
    end


function editLocalLocation_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to editLocalLocation (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editLocalLocation as text
    %        str2double(get(hObject,'String')) returns contents of editLocalLocation as a double


% --- Executes during object creation, after setting all properties.
function editLocalLocation_CreateFcn(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to editLocalLocation (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in pushbuttonLocalLocation.
function pushbuttonLocalLocation_Callback(hObject, eventdata, handles)  %#ok<DEFNU,INUSL>
    % hObject    handle to pushbuttonLocalLocation (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    path = uigetdir('','Select a directory to store local backups of processed data');
    set(handles.editLocalLocation,'String',path);

% --------------------------------------------------------------------
function menuFile_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to menuFile (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuFileNew_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
    % hObject    handle to menuFileNew (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    resetAllFields(handles);
    set(handles.textStatus,'string','Enter new settings');
    
function resetAllFields(handles)
    set(handles.editUsername,'string','');
    set(handles.editEmail,'string','');
    set(handles.editLocalLocation,'string','');
    set(handles.checkboxHoverZoom,'Value',0);
    set(handles.checkboxSaveLocal,'Value',0);
    set(handles.checkboxSaveAtSbx,'Value',0);
    set(handles.checkboxRequireAnalyzer,'Value',0);
    set(handles.editLocalLocation,'Enable','off');
    set(handles.pushbuttonLocalLocation,'Enable','off');
    

% --------------------------------------------------------------------
function menuFileOpen_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
    % hObject    handle to menuFileOpen (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    [filename, pathname] = uigetfile('*.mat', 'Select setting file to import...');
    if ~isequal(filename,0) && ~isequal(pathname,0)
       load(fullfile(pathname, filename));
       if ~exist('setting','var')
           errordlg('Invalid settings file.','File Error');
       else
           fillFields(setting,handles);
           save('settings/currentSettings.mat','setting'); 
       end
    end


% --------------------------------------------------------------------
function menuFileSave_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
    % hObject    handle to menuFileSave (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    saveAllSettings(handles);
    
    
function saveAllSettings(handles)
    setting.uName = get(handles.editUsername,'string');
    setting.email = get(handles.editEmail,'string');
    
    setting.doHoverZoom     = get(handles.checkboxHoverZoom,'Value');
    setting.doSaveLocal     = get(handles.checkboxSaveLocal,'Value');
    setting.doSaveAtSbx     = get(handles.checkboxSaveAtSbx,'Value');
    setting.requireAnalyzer = get(handles.checkboxRequireAnalyzer,'Value');
    
    if setting.doSaveLocal
        setting.localSaveLocation = get(handles.editLocalLocation,'string');
    else
        setting.localSaveLocation = '';
    end
    save(['settings/' setting.uName '.mat'],'setting');
    save('settings/currentSettings.mat','setting'); 
    set(handles.textStatus,'string',['Settings saved for ' setting.uName]);

% --------------------------------------------------------------------
function menuFileExit_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
    % hObject    handle to menuFileExit (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    figureTwoPhotonAnalysisPrefs_CloseRequestFcn(handles.figureTwoPhotonAnalysisPrefs, eventdata, handles)
    

% --- Executes when user attempts to close figureTwoPhotonAnalysisPrefs.
function figureTwoPhotonAnalysisPrefs_CloseRequestFcn(hObject, eventdata, handles)  %#ok<INUSL>
    % hObject    handle to figureTwoPhotonAnalysisPrefs (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: delete(hObject) closes the figure
    
    % use clearall to get rid of 'do not ask to save preferences dialog' 
    % uisetpref('save2pPrefsbeforeclosing','ask'); 

    selectedButton = uigetpref('graphics','save2pPrefsbeforeclosing','Closing Preferences',...
        {'Do you want to save your figure before closing?' '' ''},...
        {'y','n';'Yes','No'},...
        'ExtraOptions','Cancel',...
        'DefaultButton','Cancel');
    
    if strcmp(selectedButton,'cancel')
        return;
    end
        
    if selectedButton == 'y'
        saveAllSettings(handles);
    end
    
    delete(hObject);


% --- Executes on button press in checkboxRequireAnalyzer.
function checkboxRequireAnalyzer_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxRequireAnalyzer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxRequireAnalyzer


% --- Executes on button press in checkboxSaveAtSbx.
function checkboxSaveAtSbx_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxSaveAtSbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxSaveAtSbx
