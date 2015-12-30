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

    % Last Modified by GUIDE v2.5 26-Dec-2015 19:25:12

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
function twoPhotonAnalysisData_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<INUSL>
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
    
    pullDataInputs.align       = varargin{2};
    pullDataInputs.image       = varargin{3};
    pullDataInputs.segment     = varargin{4};
    pullDataInputs.analyzer    = varargin{5};
    
    pullDataInputs.preDelay    = 1000*pullDataInputs.analyzer.P.param{1}{3}; % this is how zdata did it. 
    pullDataInputs.postDelay   = 1000*pullDataInputs.analyzer.P.param{2}{3}; % Should do this using getparamval instead
    pullDataInputs.stimDur     = 1000*pullDataInputs.analyzer.P.param{3}{3};
    
    set(handles.textPreDelay,   'String',[num2str(pullDataInputs.preDelay) ' ms']);
    set(handles.textStimDur,    'String',[num2str(pullDataInputs.stimDur) ' ms']);
    set(handles.textPostDelay,  'String',[num2str(pullDataInputs.postDelay) ' ms']);
    
    % Use these to set up default signal acquisition epochs
    pullDataInputs.baseStart   = -min(1000,pullDataInputs.preDelay);
    pullDataInputs.baseEnd     = 0;
    pullDataInputs.respStart   = 200;
    pullDataInputs.respEnd     = pullDataInputs.stimDur + 200;
    pullDataInputs.rangeStart  = -pullDataInputs.preDelay;
    pullDataInputs.rangeEnd    = pullDataInputs.stimDur + pullDataInputs.postDelay;
    
    % Place these values in the GUI
    set(handles.editBaseStart,  'String',num2str(pullDataInputs.baseStart));
    set(handles.editBaseEnd,    'String',num2str(pullDataInputs.baseEnd));
    set(handles.editRespStart,  'String',num2str(pullDataInputs.respStart));
    set(handles.editRespEnd,    'String',num2str(pullDataInputs.respEnd));
    set(handles.editRangeStart, 'String',num2str(pullDataInputs.rangeStart));
    set(handles.editRangeEnd,   'String',num2str(pullDataInputs.rangeEnd));
    
    % Set a default filter width
    pullDataInputs.filterWidth = 100;
    set(handles.editFiltWidth,  'String',num2str(pullDataInputs.filterWidth));
    
    pullDataInputs.alignNames = cell(length(pullDataInputs.align)+2,1);
    pullDataInputs.alignNames{1} = 'Select align...';
    pullDataInputs.alignNames{2} = 'none';
    for ii=1:length(pullDataInputs.align)
        pullDataInputs.alignNames{ii+2} = pullDataInputs.align(ii).name;
    end
    
    set(handles.popupmenuAlign,'string',pullDataInputs.alignNames);
    save('localBackups/pullDataInputs_temp.mat','pullDataInputs');
    refreshAxis(handles);
    
function refreshAxis(handles)
    load('localBackups/pullDataInputs_temp.mat');
    cla(handles.axisTiming);
    fakeT = linspace(pullDataInputs.rangeStart,pullDataInputs.rangeEnd,200);
    fakeR = zeros(1,200);
    fakeR(fakeT >= pullDataInputs.respStart & fakeT <= pullDataInputs.respEnd) = 1;
    smoothingKernel = ones(11,1);
    fakeR = padarray(fakeR,[0 10]);
    fakeR = conv(fakeR,smoothingKernel,'valid');
    fakeR = conv(fakeR,smoothingKernel,'valid');
    fakeR = fakeR/max(fakeR);
    plot(handles.axisTiming,fakeT,fakeR,'c','linewidth',3);
    hold(handles.axisTiming,'on');
    set(handles.axisTiming,'xlim',[pullDataInputs.rangeStart pullDataInputs.rangeEnd],'ylim',[-0.2 1.5]);
    set(handles.axisTiming,'tickdir','out','xcolor','w','ycolor','w','ticklength',[0.03 0.03]);
    line([0 0],[-0.2 1.5],'color','b','linewidth',3,'parent',handles.axisTiming);
    line([pullDataInputs.stimDur pullDataInputs.stimDur],[-0.2 1.5],'color','b','linewidth',3,'parent',handles.axisTiming);
    fill([pullDataInputs.respStart pullDataInputs.respStart pullDataInputs.respEnd pullDataInputs.respEnd],[-0.2 1.5 1.5 -0.2],'m','linestyle','none');
    fill([pullDataInputs.baseStart pullDataInputs.baseStart pullDataInputs.baseEnd pullDataInputs.baseEnd],[-0.2 1.5 1.5 -0.2],'g','linestyle','none');
    alpha(0.3);
    

% --- Outputs from this function are returned to the command line.
function varargout = twoPhotonAnalysisData_OutputFcn(hObject, eventdata, handles)  %#ok<INUSL>
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;



function editBaseStart_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
    % hObject    handle to editBaseStart (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editBaseStart as text
    %        str2double(get(hObject,'String')) returns contents of editBaseStart as a double
    load('localBackups/pullDataInputs_temp.mat');
    pullDataInputs.baseStart = str2double(get(hObject,'String'));
    save('localBackups/pullDataInputs_temp.mat','pullDataInputs');
    refreshAxis(handles);

% --- Executes during object creation, after setting all properties.
function editBaseStart_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
    % hObject    handle to editBaseStart (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end



function editRespStart_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
    % hObject    handle to editRespStart (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editRespStart as text
    %        str2double(get(hObject,'String')) returns contents of editRespStart as a double
    load('localBackups/pullDataInputs_temp.mat');
    pullDataInputs.respStart = str2double(get(hObject,'String'));
    save('localBackups/pullDataInputs_temp.mat','pullDataInputs');
    refreshAxis(handles);

% --- Executes during object creation, after setting all properties.
function editRespStart_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
    % hObject    handle to editRespStart (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function editRangeStart_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
    % hObject    handle to editRangeStart (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editRangeStart as text
    %        str2double(get(hObject,'String')) returns contents of editRangeStart as a double
    load('localBackups/pullDataInputs_temp.mat');
    pullDataInputs.rangeStart = str2double(get(hObject,'String'));
    save('localBackups/pullDataInputs_temp.mat','pullDataInputs');
    refreshAxis(handles);
    
    
% --- Executes during object creation, after setting all properties.
function editRangeStart_CreateFcn(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to editRangeStart (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function editBaseEnd_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
    % hObject    handle to editBaseEnd (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editBaseEnd as text
    %        str2double(get(hObject,'String')) returns contents of editBaseEnd as a double
    load('localBackups/pullDataInputs_temp.mat');
    pullDataInputs.baseEnd = str2double(get(hObject,'String'));
    save('localBackups/pullDataInputs_temp.mat','pullDataInputs');
    refreshAxis(handles);
    
% --- Executes during object creation, after setting all properties.
function editBaseEnd_CreateFcn(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to editBaseEnd (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end



function editRangeEnd_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
    % hObject    handle to editRangeEnd (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editRangeEnd as text
    %        str2double(get(hObject,'String')) returns contents of editRangeEnd as a double
    load('localBackups/pullDataInputs_temp.mat');
    pullDataInputs.rangeEnd = str2double(get(hObject,'String'));
    save('localBackups/pullDataInputs_temp.mat','pullDataInputs');
    refreshAxis(handles);

    
% --- Executes during object creation, after setting all properties.
function editRangeEnd_CreateFcn(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to editRangeEnd (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function editRespEnd_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
    % hObject    handle to editRespEnd (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editRespEnd as text
    %        str2double(get(hObject,'String')) returns contents of editRespEnd as a double
    load('localBackups/pullDataInputs_temp.mat');
    pullDataInputs.respEnd = str2double(get(hObject,'String'));
    save('localBackups/pullDataInputs_temp.mat','pullDataInputs');
    refreshAxis(handles);
    

% --- Executes during object creation, after setting all properties.
function editRespEnd_CreateFcn(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to editRespEnd (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function editFiltWidth_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
    % hObject    handle to editFiltWidth (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editFiltWidth as text
    %        str2double(get(hObject,'String')) returns contents of editFiltWidth as a double
    load('localBackups/pullDataInputs_temp.mat');
    pullDataInputs.filtWidth = str2double(get(hObject,'String'));
    save('localBackups/pullDataInputs_temp.mat','pullDataInputs');
    refreshAxis(handles);

% --- Executes during object creation, after setting all properties.
function editFiltWidth_CreateFcn(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to editFiltWidth (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in radiobuttonLocal.
function radiobuttonLocal_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to radiobuttonLocal (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of radiobuttonLocal
    

% --- Executes on button press in radiobuttonCluster.
function radiobuttonCluster_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to radiobuttonCluster (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of radiobuttonCluster


% --- Executes on button press in pushbuttonPull.
function pushbuttonPull_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbuttonPull (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    


% --- Executes on selection change in popupmenuAlign.
function popupmenuAlign_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to popupmenuAlign (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns popupmenuAlign contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from popupmenuAlign


% --- Executes during object creation, after setting all properties.
function popupmenuAlign_CreateFcn(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
    % hObject    handle to popupmenuAlign (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
