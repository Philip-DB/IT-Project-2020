unit PAT_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.ExtCtrls,
  Vcl.Samples.Spin, Vcl.Menus, Vcl.Buttons, Vcl.Imaging.pngimage, dmHospital_u,
  Vcl.Imaging.jpeg, Vcl.DBCtrls, Vcl.Themes, ShellAPI;

type
  TfrmMainProj = class(TForm)
    tsMain: TPageControl;
    tsLogin: TTabSheet;
    Home: TTabSheet;
    lblLoginHeading: TLabel;
    btnStaffLogin: TButton;
    btnVisitorLogin: TButton;
    lblHomeHeading: TLabel;
    btnDocters: TButton;
    btnGeneralInfo: TButton;
    btnDrugs: TButton;
    tsInfo: TTabSheet;
    tsDocters: TTabSheet;
    tsMeds: TTabSheet;
    cmbMenuChoice: TComboBox;
    lblMenuChoice: TLabel;
    redMenuOutput: TRichEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    btnMap: TButton;
    btnVisitHours: TButton;
    rbgDocterSort: TRadioGroup;
    rbgPatientSort: TRadioGroup;
    btnDocIDSort: TButton;
    sedDocID: TSpinEdit;
    btnPatNumSort: TButton;
    btnHowManyPatients: TButton;
    sedPatientID: TSpinEdit;
    btnBuyMeds: TButton;
    lblScriptHeading: TLabel;
    spnMedID: TSpinEdit;
    lblMedID: TLabel;
    spnAmountBottle: TSpinEdit;
    lblMedAmount: TLabel;
    MainMenu1: TMainMenu;
    Menu1: TMenuItem;
    Help1: TMenuItem;
    Logout1: TMenuItem;
    Home1: TMenuItem;
    btnDischarge: TBitBtn;
    imgLogin: TImage;
    btnAddPatient: TBitBtn;
    imgVisitingHours: TImage;
    imgMap: TImage;
    Panel1: TPanel;
    Label2: TLabel;
    imgQuestion: TImage;
    btnMostSold: TButton;
    btnAverage: TButton;
    pnlMostSold: TPanel;
    pnlAverage: TPanel;
    btnResetFilter: TBitBtn;
    btnEditPatient: TButton;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    btnSortLow: TButton;
    btnSortHigh: TButton;
    cbxDarkMode: TCheckBox;
    Close1: TMenuItem;
    pnlMedInfo: TPanel;
    redMedOut: TRichEdit;
    btnCheckout: TButton;
    lblCheckout: TLabel;
    imgBGMed: TImage;
    btnClearMed: TBitBtn;
    lblExtraInfo: TLabel;
    btnCovidInfo: TBitBtn;
    pnlNav: TPanel;
    pnlExtraInfo: TPanel;
    imgHomeBG: TImage;
    pnlWelcome: TPanel;
    TimerDate: TTimer;
    lblDate: TLabel;
    pnlDate: TPanel;
    lblCovidHeading: TLabel;
    procedure btnGeneralInfoClick(Sender: TObject);
    procedure btnDoctersClick(Sender: TObject);
    procedure btnDrugsClick(Sender: TObject);
    procedure btnHomeGenClick(Sender: TObject);
    procedure btnHomeDocClick(Sender: TObject);
    procedure btnHomeMedicineClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnStaffLoginClick(Sender: TObject);
    procedure btnVisitorLoginClick(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure Logout1Click(Sender: TObject);
    procedure Home1Click(Sender: TObject);
    procedure btnVisitHoursClick(Sender: TObject);
    procedure btnMapClick(Sender: TObject);
    procedure rbgDocterSortClick(Sender: TObject);
    procedure btnDocIDSortClick(Sender: TObject);
    procedure btnResetFilterClick(Sender: TObject);
    procedure btnPatNumSortClick(Sender: TObject);
    procedure btnHowManyPatientsClick(Sender: TObject);
    procedure btnDischargeClick(Sender: TObject);
    procedure btnAddPatientClick(Sender: TObject);
    procedure btnEditPatientClick(Sender: TObject);
    procedure rbgPatientSortClick(Sender: TObject);
    procedure cmbMenuChoiceChange(Sender: TObject);
    procedure cbxDarkModeClick(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure btnSortLowClick(Sender: TObject);
    procedure btnSortHighClick(Sender: TObject);
    procedure spnMedIDChange(Sender: TObject);
    procedure spnAmountBottleChange(Sender: TObject);
    procedure btnBuyMedsClick(Sender: TObject);
    procedure btnCheckoutClick(Sender: TObject);
    procedure btnClearMedClick(Sender: TObject);
    procedure btnMostSoldClick(Sender: TObject);
    procedure btnAverageClick(Sender: TObject);
    procedure btnCovidInfoClick(Sender: TObject);
    procedure TimerDateTimer(Sender: TObject);
  private
    { Private declarations }
    function IsValidID(sID: String): Boolean;
    function IsValidRoomNum(sRoomNum: String): Boolean;
    function IsValidFirstName(sFirstName: String): Boolean;
    function IsValidSurname(sSurname: String): Boolean;
    function IsValidDocID(sDocID: String): Boolean;
    function IsValidGender(sGender: String): Boolean;

    procedure LoadTextFile(sTextfile: String);
    procedure AlignTabs;

  var
    bLoggedIn: Boolean;
    iCounter: Integer;
    rTotalMedicineCost: real;

    arrItemName: array [1 .. 50] of String;
    arrItemPrice: array [1 .. 50] of Integer;
  public
    { Public declarations }
  end;

var
  frmMainProj: TfrmMainProj;

implementation

{$R *.dfm}

procedure TfrmMainProj.cbxDarkModeClick(Sender: TObject);
begin
  if cbxDarkMode.Checked = True then
  begin
    frmMainProj.Enabled := False;
    TStyleManager.SetStyle('TabletDark');
    frmMainProj.Enabled := True;
  end
  else
  begin
    frmMainProj.Enabled := False;
    TStyleManager.SetStyle('Tablet Light');
    frmMainProj.Enabled := True;
  end;

end;

procedure TfrmMainProj.Close1Click(Sender: TObject);
begin
  Halt;
end;

procedure TfrmMainProj.btnDischargeClick(Sender: TObject);
begin

  with dmHospital do
  begin
    if MessageDlg('Are you sure that you want to discharge ' + tblPatients
      ['PatientFirstName'] + ' ' + tblPatients['PatientSurname'] +
      ' from the hospital?', mtWarning, [mbOk, mbCancel], 0) = mrOK then
    begin
      tblPatients.Delete;
      ShowMessage('Patient discharged!');

    end
    else
    begin
      ShowMessage('Patient not discharged');
      exit;

    end;
  end;

end;

procedure TfrmMainProj.AlignTabs;
begin
  redMenuOutput.SelectAll;
  redMenuOutput.Paragraph.TabCount := 1;
  redMenuOutput.Paragraph.Tab[0] := 100;
end;

procedure TfrmMainProj.btnAddPatientClick(Sender: TObject);
var
  sFirstName, sSurname, sID, sRoomNum, sDocNum, sGender: String;
  iRoomNum, iDocNum: Integer;
  bFlagName, bFlagSurname, bFlagID, bFlagRoomNum, bFlagDocAssign,
    bFlagGender: Boolean;
begin
  bFlagGender := False;
  bFlagName := False;
  bFlagSurname := False;
  bFlagID := False;
  bFlagRoomNum := False;
  bFlagDocAssign := False;
  with dmHospital do
  begin
    tblPatients.Last;
    tblPatients.Insert;

    sGender := InputBox('Please enter the patients gender',
      'Enter either M or F only', 'M');

    sFirstName := InputBox('Please enter the patients first name',
      'Enter first name below', '');

    sSurname := InputBox('Please enter the patients surname',
      'Enter surname below', '');

    sID := InputBox('Please enter the patients ID Number',
      'Enter the ID Number below', '');

    sRoomNum := InputBox('Please enter the patients room number',
      'Enter room number below', '');

    sDocNum := InputBox
      ('Please enter the docters ID number who will care for this patient',
      'Enter docter ID number below', '');

    if IsValidGender(sGender) then
      bFlagGender := True;

    if IsValidID(sID) = True then
      bFlagID := True;

    if IsValidRoomNum(sRoomNum) then
    begin
      bFlagRoomNum := True;
      iRoomNum := StrToInt(sRoomNum);
    end;

    if IsValidFirstName(sFirstName) = True then
      bFlagName := True;

    if IsValidSurname(sSurname) = True then
      bFlagSurname := True;

    if IsValidDocID(sDocNum) then
    begin
      bFlagDocAssign := True;
      iDocNum := StrToInt(sDocNum);
    end;

    if bFlagName AND bFlagSurname AND bFlagID AND bFlagRoomNum AND
      bFlagDocAssign AND bFlagGender then
    begin
      tblPatients['PatientFirstName'] := sFirstName;
      tblPatients['PatientSurname'] := sSurname;
      tblPatients['PatientIDNumber'] := sID;
      tblPatients['AssignedDocterID'] := iDocNum;
      tblPatients['RoomNumber'] := iRoomNum;
      tblPatients['Gender'] := sGender;

      tblPatients.Post;

    end
    else
      tblPatients.First;

  end;
end;

procedure TfrmMainProj.btnAverageClick(Sender: TObject);
var
  iCount: Integer;
  rAverage, rSum: real;
begin
  iCount := 0;
  rAverage := 0;
  with dmHospital do
  begin
    tblMeds.First;

    while not tblMeds.Eof do
    begin
      Inc(iCount);
      rSum := rSum + tblMeds['AmountSold'];
      tblMeds.Next;
    end;
    rAverage := rSum / iCount;

    pnlAverage.Caption := FloatToStrF(rAverage, ffFixed, 8, 2);
  end;
end;

procedure TfrmMainProj.btnCheckoutClick(Sender: TObject);
var
  sFirstName, sSurname: String;
  bFlagName, bFlagSurname: Boolean;

begin
  bFlagName := False;
  bFlagSurname := False;
  sFirstName := InputBox('Please enter your first name',
    'Enter first name below', '');

  sSurname := InputBox('Please enter your surname', 'Enter surname below', '');

  if IsValidFirstName(sFirstName) then
    bFlagName := True;

  if IsValidSurname(sSurname) then
    bFlagSurname := True;

  if (bFlagName = False) or (bFlagSurname = False) then
    exit;
  redMedOut.Lines.Add
    ('-------------------------------------------------------------------------------');
  redMedOut.Lines.Add(#13);
  redMedOut.SelAttributes.Style := [fsBold];
  redMedOut.Lines.Add('Reciept for ' + sFirstName + ' ' + sSurname);
  redMedOut.Lines.Add('Total cost is  :' + FloatToStrF(rTotalMedicineCost,
    ffCurrency, 8, 2));

  btnCheckout.Enabled := False;

  btnClearMed.Enabled := True;
  rTotalMedicineCost := 0;

end;

procedure TfrmMainProj.btnClearMedClick(Sender: TObject);
begin
  btnBuyMeds.Enabled := True;
  redMedOut.Lines.Clear;
  redMedOut.SelAttributes.Style := [fsBold];
  redMedOut.Lines.Add('Shopping cart');
end;

procedure TfrmMainProj.btnCovidInfoClick(Sender: TObject);
var
  sURL: String;
begin
  sURL := 'https://www.who.int/emergencies/diseases/novel-coronavirus-2019';
  // Using ShellExecute to open a website , URL holds the website string to be excuted.
  ShellExecute(0, 'open', PChar(sURL), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMainProj.btnBuyMedsClick(Sender: TObject);
var
  iIDMed, iBotAmount, iCost: Integer;
  rTotal, rIndivCost: real;
  bFound: Boolean;

begin
  btnClearMed.Enabled := False;
  bFound := False;
  with dmHospital do
  begin
    rIndivCost := 0;
    iIDMed := spnMedID.Value;
    iBotAmount := spnAmountBottle.Value;

    tblMeds.First;
    while not tblMeds.Eof do
    begin

      if iIDMed = tblMeds['MedicineID'] then
      begin
        iCost := tblMeds['CostPerBottle (R)'];
        bFound := True;

        tblMeds.Edit;
        tblMeds['AmountSold'] := tblMeds['AmountSold'] + iBotAmount;
        tblMeds.Post;
        Break;
      end
      else
      begin
        bFound := False;
      end;
      tblMeds.Next;
    end;

    if bFound = False then
    begin
      ShowMessage('Medicine not found');
      redMedOut.Lines.Clear;
      exit;
    end;

    rIndivCost := iCost * iBotAmount;
    rTotalMedicineCost := rTotalMedicineCost + rIndivCost;
    redMedOut.Lines.Add(tblMeds['MedicineName'] + #9 + FloatToStrF(rIndivCost,
      ffCurrency, 8, 2));

    if MessageDlg('Are you finished shopping? ', mtConfirmation, [mbYes, mbNo],
      0) = mrYes then
    begin
      btnBuyMeds.Enabled := False;
      btnCheckout.Enabled := True;
      exit;
    end;

  end;

end;

procedure TfrmMainProj.btnDocIDSortClick(Sender: TObject);
var
  iSearchNum: Integer;
  bFound: Boolean;
begin
  bFound := False;
  iSearchNum := sedDocID.Value;

  with dmHospital do
  begin
    tblDocters.First;

    while not tblDocters.Eof do
    begin

      if tblDocters['DocterID'] = iSearchNum then
      begin
        bFound := True;
        ShowMessage('Docter found was ' + tblDocters['DocterName'] + ' ' +
          tblDocters['DocterSurname']);
        exit;
      end;

      tblDocters.Next;
    end;
    if bFound = False then
    begin
      ShowMessage('Doctor not found!');
      exit;
    end;
  end;

end;

procedure TfrmMainProj.btnDoctersClick(Sender: TObject);
begin
  tsMain.Pages[3].TabVisible := True;
  tsMain.ActivePageIndex := 3;
  tsMain.Pages[0].TabVisible := False;
  tsMain.Pages[1].TabVisible := False;
  tsMain.Pages[2].TabVisible := False;
  tsMain.Pages[4].TabVisible := False;
end;

procedure TfrmMainProj.btnDrugsClick(Sender: TObject);
begin
  tsMain.Pages[4].TabVisible := True;
  tsMain.ActivePageIndex := 4;
  tsMain.Pages[0].TabVisible := False;
  tsMain.Pages[1].TabVisible := False;
  tsMain.Pages[3].TabVisible := False;
  tsMain.Pages[2].TabVisible := False;
end;

procedure TfrmMainProj.btnEditPatientClick(Sender: TObject);
var
  sFirstName, sSurname, sID, sRoomNum, sDocNum, sGender: String;
  iRoomNum, iDocNum: Integer;
  bFlagName, bFlagSurname, bFlagID, bFlagRoomNum, bFlagDocAssign,
    bFlagGender: Boolean;
begin
  bFlagGender := False;
  bFlagName := False;
  bFlagSurname := False;
  bFlagID := False;
  bFlagRoomNum := False;
  bFlagDocAssign := False;
  with dmHospital do
  begin

    tblPatients.Edit;

    sGender := InputBox('Please enter the patients gender',
      'Enter either M or F only', tblPatients['Gender']);

    sFirstName := InputBox('Please enter the patients first name',
      'Enter first name below', tblPatients['PatientFirstName']);

    sSurname := InputBox('Please enter the patients surname',
      'Enter surname below', tblPatients['PatientSurname']);

    sID := InputBox('Please enter the patients ID Number',
      'Enter the ID Number below', tblPatients['PatientIDNumber']);

    sRoomNum := InputBox('Please enter the patients room number',
      'Enter room number below', tblPatients['RoomNumber']);

    sDocNum := InputBox
      ('Please enter the docters ID number who will care for this patient',
      'Enter docter ID number below', tblPatients['AssignedDocterID']);

    if IsValidGender(sGender) then
      bFlagGender := True;

    if IsValidID(sID) = True then
      bFlagID := True;

    if IsValidRoomNum(sRoomNum) then
    begin
      bFlagRoomNum := True;
      iRoomNum := StrToInt(sRoomNum);
    end;

    if IsValidFirstName(sFirstName) = True then
      bFlagName := True;

    if IsValidSurname(sSurname) = True then
      bFlagSurname := True;

    if IsValidDocID(sDocNum) then
    begin
      bFlagDocAssign := True;
      iDocNum := StrToInt(sDocNum);
    end;

    if bFlagName AND bFlagSurname AND bFlagID AND bFlagRoomNum AND
      bFlagDocAssign AND bFlagGender then
    begin
      tblPatients['PatientFirstName'] := sFirstName;
      tblPatients['PatientSurname'] := sSurname;
      tblPatients['PatientIDNumber'] := sID;
      tblPatients['AssignedDocterID'] := iDocNum;
      tblPatients['RoomNumber'] := iRoomNum;
      tblPatients['Gender'] := sGender;

      tblPatients.Post;

    end;

  end;
end;

procedure TfrmMainProj.btnGeneralInfoClick(Sender: TObject);
begin
  tsMain.Pages[2].TabVisible := True;
  tsMain.ActivePageIndex := 2;
  tsMain.Pages[0].TabVisible := False;
  tsMain.Pages[1].TabVisible := False;
  tsMain.Pages[3].TabVisible := False;
  tsMain.Pages[4].TabVisible := False;
end;

procedure TfrmMainProj.btnHomeDocClick(Sender: TObject);
begin
  tsMain.Pages[1].TabVisible := True;
  tsMain.ActivePageIndex := 1;
  tsMain.Pages[0].TabVisible := False;
  tsMain.Pages[2].TabVisible := False;
  tsMain.Pages[3].TabVisible := False;
  tsMain.Pages[4].TabVisible := False;
end;

procedure TfrmMainProj.btnHomeGenClick(Sender: TObject);
begin
  tsMain.Pages[1].TabVisible := True;
  tsMain.ActivePageIndex := 1;
  tsMain.Pages[0].TabVisible := False;
  tsMain.Pages[2].TabVisible := False;
  tsMain.Pages[3].TabVisible := False;
  tsMain.Pages[4].TabVisible := False;
end;

procedure TfrmMainProj.btnHomeMedicineClick(Sender: TObject);
begin
  tsMain.Pages[1].TabVisible := True;
  tsMain.ActivePageIndex := 1;
  tsMain.Pages[0].TabVisible := False;
  tsMain.Pages[2].TabVisible := False;
  tsMain.Pages[3].TabVisible := False;
  tsMain.Pages[4].TabVisible := False;
end;

procedure TfrmMainProj.btnMapClick(Sender: TObject);
begin
  imgVisitingHours.Visible := False;
  imgMap.Visible := True;
  imgQuestion.Visible := False;
end;

procedure TfrmMainProj.btnMostSoldClick(Sender: TObject);
var
  iHighest, iCompare: Integer;
  sHighestName: String;
begin
  with dmHospital do
  begin
    tblMeds.First;
    iHighest := tblMeds['AmountSold'];
    sHighestName := tblMeds['MedicineName'];

    while NOT tblMeds.Eof do
    begin
      iCompare := tblMeds['AmountSold'];

      if (iHighest < iCompare) then
      begin
        iHighest := iCompare;
        sHighestName := tblMeds['MedicineName'];
      end;
      tblMeds.Next;
    end;
    pnlMostSold.Caption := sHighestName;
  end;
end;

procedure TfrmMainProj.btnHowManyPatientsClick(Sender: TObject);
var
  bFound: Boolean;
  iDocID, iCount: Integer;
  sPatients: String;
begin
  bFound := False;
  iCount := 0;
  iDocID := 0;
  sPatients := '';

  with dmHospital do
  begin
    iDocID := tblDocters['DocterID'];

    tblPatients.First;
    while not tblPatients.Eof do
    begin
      if tblPatients['AssignedDocterID'] = iDocID then
      begin
        bFound := True;
        Inc(iCount);
        sPatients := sPatients + tblPatients['PatientFirstName'] + ' ' +
          tblPatients['PatientSurname'] + #13;
      end;
      tblPatients.Next;
    end;

    if bFound = True then
    begin
      ShowMessage(tblDocters['DocterName'] + ' ' + tblDocters['DocterSurname'] +
        ' had ' + IntToStr(iCount) + ' patient/s.' + #13 + 'And they were: ' +
        #13 + sPatients);
    end
    else
      ShowMessage('Doctor does not have any patients!');
  end;
end;

procedure TfrmMainProj.btnPatNumSortClick(Sender: TObject);
var
  iSearchNum: Integer;
  bFound: Boolean;
begin
  bFound := False;
  iSearchNum := sedPatientID.Value;

  with dmHospital do
  begin
    tblPatients.First;
    while not tblPatients.Eof do
    begin
      if tblPatients['PatientID'] = iSearchNum then
      begin
        bFound := True;
        ShowMessage('Patient found was ' + tblPatients['PatientFirstName'] + ' '
          + tblPatients['PatientSurname']);
        exit;

      end;
      tblPatients.Next;
    end;

    if bFound = False then
      ShowMessage('Patient not found!');

  end;
end;

procedure TfrmMainProj.btnResetFilterClick(Sender: TObject);
begin
  with dmHospital do
  begin
    tblDocters.Filtered := False;
    tblDocters.Sort := '';

    tblPatients.Filtered := False;
    tblPatients.Sort := '';
  end;
  sedDocID.Value := 0;
  sedPatientID.Value := 0;
end;

procedure TfrmMainProj.btnSortHighClick(Sender: TObject);

var
  I, J: Integer;
  sTempName: String;
  iTempPrice: Integer;
begin

  redMenuOutput.Lines.Clear;

  I := 0;
  J := 0;

  for I := 1 to iCounter do
  begin
    for J := 1 to (iCounter - 1) do
    begin
      if arrItemPrice[J] < arrItemPrice[J + 1] then
      begin
        iTempPrice := arrItemPrice[J];
        arrItemPrice[J] := arrItemPrice[J + 1];
        arrItemPrice[J + 1] := iTempPrice;

        sTempName := arrItemName[J];
        arrItemName[J] := arrItemName[J + 1];
        arrItemName[J + 1] := sTempName;

      end;
    end;
  end;

  case cmbMenuChoice.ItemIndex of
    1:
      begin
        redMenuOutput.SelectAll;
        redMenuOutput.Paragraph.TabCount := 1;
        redMenuOutput.Paragraph.Tab[0] := 100;
        redMenuOutput.Lines.Add('Hot food item' + #9 + 'Item price');
        redMenuOutput.Lines.Add
          ('--------------------------------------------------------');

      end;
    2:
      begin
        redMenuOutput.SelectAll;
        redMenuOutput.Paragraph.TabCount := 1;
        redMenuOutput.Paragraph.Tab[0] := 100;
        redMenuOutput.Lines.Add('Snack item' + #9 + 'Item price');
        redMenuOutput.Lines.Add
          ('--------------------------------------------------------');

      end;
    3:
      begin
        redMenuOutput.SelectAll;
        redMenuOutput.Paragraph.TabCount := 1;
        redMenuOutput.Paragraph.Tab[0] := 100;
        redMenuOutput.Lines.Add('Drink' + #9 + 'Item price');
        redMenuOutput.Lines.Add
          ('--------------------------------------------------------');

      end;
  end;

  for I := 1 to iCounter do
  begin
    redMenuOutput.Lines.Add(arrItemName[I] + #9 + 'R' +
      IntToStr(arrItemPrice[I]));

  end;
end;

procedure TfrmMainProj.btnSortLowClick(Sender: TObject);
var
  I, J: Integer;
  sTempName: String;
  iTempPrice: Integer;
begin

  redMenuOutput.Lines.Clear;

  I := 0;
  J := 0;

  for I := 1 to iCounter do
  begin
    for J := 1 to (iCounter - 1) do
    begin
      if arrItemPrice[J] > arrItemPrice[J + 1] then
      begin
        iTempPrice := arrItemPrice[J];
        arrItemPrice[J] := arrItemPrice[J + 1];
        arrItemPrice[J + 1] := iTempPrice;

        sTempName := arrItemName[J];
        arrItemName[J] := arrItemName[J + 1];
        arrItemName[J + 1] := sTempName;

      end;
    end;
  end;

  case cmbMenuChoice.ItemIndex of
    1:
      begin
        AlignTabs;
        redMenuOutput.Lines.Add('Hot food item' + #9 + 'Item price');
        redMenuOutput.Lines.Add
          ('--------------------------------------------------------');

      end;
    2:
      begin
        AlignTabs;
        redMenuOutput.Lines.Add('Snack item' + #9 + 'Item price');
        redMenuOutput.Lines.Add
          ('--------------------------------------------------------');

      end;
    3:
      begin
        AlignTabs;
        redMenuOutput.Lines.Add('Drink' + #9 + 'Item price');
        redMenuOutput.Lines.Add
          ('--------------------------------------------------------');

      end;
  end;

  for I := 1 to iCounter do
  begin
    redMenuOutput.Lines.Add(arrItemName[I] + #9 + 'R' +
      IntToStr(arrItemPrice[I]));

  end;

end;

procedure TfrmMainProj.btnStaffLoginClick(Sender: TObject);
var

  sPasswordEntered: String;
begin

  sPasswordEntered := InputBox('Staff Login', 'Please enter the staff password',
    'Password here');

  if sPasswordEntered = 'Pogchamp' then
  begin
    ShowMessage('Logging in!');
    tsMain.Pages[1].TabVisible := True;
    tsMain.ActivePageIndex := 1;
    tsMain.Pages[0].TabVisible := False;
    tsMain.Pages[2].TabVisible := False;
    tsMain.Pages[3].TabVisible := False;
    tsMain.Pages[4].TabVisible := False;

    btnDischarge.Visible := True;
    btnEditPatient.Visible := True;
    btnAddPatient.Visible := True;

    bLoggedIn := True;

    lblHomeHeading.Caption := ' Welcome staff member! ';
  end
  else
    ShowMessage('Incorrect password!');

end;

procedure TfrmMainProj.btnVisitorLoginClick(Sender: TObject);
begin
  ShowMessage('Logging in!');
  tsMain.Pages[1].TabVisible := True;
  tsMain.ActivePageIndex := 1;
  tsMain.Pages[0].TabVisible := False;
  tsMain.Pages[2].TabVisible := False;
  tsMain.Pages[3].TabVisible := False;
  tsMain.Pages[4].TabVisible := False;

  bLoggedIn := True;

  lblHomeHeading.Caption := ' Welcome visitor ';
  ShowMessage('Welcome visitor!');

  btnDischarge.Visible := False;
  btnEditPatient.Visible := False;
  btnAddPatient.Visible := False;

end;

procedure TfrmMainProj.cmbMenuChoiceChange(Sender: TObject);
var
  sTextfile: String;
  I: Integer;
  bChanged: Boolean;

begin
  redMenuOutput.Lines.Clear;
  bChanged := False;
  begin
    case cmbMenuChoice.ItemIndex of
      1:
        begin
          AlignTabs;
          bChanged := True;
          sTextfile := 'hotfood.txt';

          redMenuOutput.Lines.Add('Hot food item' + #9 + 'Item price');
          redMenuOutput.Lines.Add
            ('--------------------------------------------------------');
          LoadTextFile(sTextfile);
        end;
      2:
        begin
          AlignTabs;
          bChanged := True;
          sTextfile := 'snacks.txt';

          redMenuOutput.Lines.Add('Snack item' + #9 + 'Item price');
          redMenuOutput.Lines.Add
            ('--------------------------------------------------------');
          LoadTextFile(sTextfile);
        end;
      3:
        begin
          AlignTabs;
          bChanged := True;
          sTextfile := 'drinks.txt';

          redMenuOutput.Lines.Add('Drink' + #9 + 'Item price');
          redMenuOutput.Lines.Add
            ('--------------------------------------------------------');
          LoadTextFile(sTextfile);
        end;

    end;
  end;

  if bChanged = True then
  begin
    for I := 1 to iCounter do
    begin
      redMenuOutput.Lines.Add(arrItemName[I] + #9 + 'R' +
        IntToStr(arrItemPrice[I]));
      btnSortLow.Enabled := True;
      btnSortHigh.Enabled := True;;
    end;
  end
  else
  begin
    btnSortLow.Enabled := False;
    btnSortHigh.Enabled := False;
  end;

end;

procedure TfrmMainProj.btnVisitHoursClick(Sender: TObject);
begin
  imgVisitingHours.Visible := True;
  imgMap.Visible := False;
  imgQuestion.Visible := False;
end;

procedure TfrmMainProj.FormActivate(Sender: TObject);
begin

  tsMain.Pages[0].TabVisible := True;
  tsMain.ActivePageIndex := 0;
  tsMain.Pages[1].TabVisible := False;
  tsMain.Pages[2].TabVisible := False;
  tsMain.Pages[3].TabVisible := False;
  tsMain.Pages[4].TabVisible := False;

  TimerDate.Enabled := True;

  imgQuestion.Visible := True;
  imgVisitingHours.Visible := False;
  imgMap.Visible := False;
  btnSortLow.Enabled := False;
  btnSortHigh.Enabled := False;
  btnBuyMeds.Enabled := False;

  redMedOut.SelAttributes.Style := [fsBold];
  redMedOut.Lines.Add('Shopping cart');

  TStyleManager.SetStyle('Tablet Light');
  rTotalMedicineCost := 0;

end;

procedure TfrmMainProj.Help1Click(Sender: TObject);
begin
  case tsMain.ActivePageIndex of

    0:
      ShowMessage
        ('This is a login hub. If you are a vistior please select visitor Login to proceed. If you are an admin please select admin Login and enter the staff password.'
        + #13 + 'If you wish to change your theme you can do so by selecting the checkbox in the bottom right corner');
    1:
      ShowMessage
        ('This is the home page of the program. Please select what you would like to do or know more about by clicking one of the below buttons');
    2:
      ShowMessage
        ('This is the general information tab of the program. Here you can view the food available at our on-site stores as well as view the map of the hospital. You can also view the visting times by clicking the button that states : Visiting hours');
    3:
      ShowMessage
        ('Here you can view our database on patients as well as information on them that your may need. You can sort by various fields and search by IDs. Also, if you are an admin you will be able to add and discharge patients');

    4:
      ShowMessage
        ('This tab is all about our pharmacy. Here you can order a script and then take it to the counter to pay. There are some facts available to browse too');

  end;
end;

procedure TfrmMainProj.Home1Click(Sender: TObject);
begin
  if bLoggedIn = True then
  begin
    tsMain.Pages[1].TabVisible := True;
    tsMain.ActivePageIndex := 1;
    tsMain.Pages[0].TabVisible := False;
    tsMain.Pages[2].TabVisible := False;
    tsMain.Pages[3].TabVisible := False;
    tsMain.Pages[4].TabVisible := False;
  end
  else
  begin
    ShowMessage('Please Login!');
  end;
end;

function TfrmMainProj.IsValidDocID(sDocID: String): Boolean;
var
  I: Integer;
begin

  if sDocID = '' then
  begin
    Result := False;
    ShowMessage('Nothing was entered for the assigned doctor ID number');
    exit;
  end;

  for I := 1 to Length(sDocID) do
  begin
    if not(sDocID[I] in ['0' .. '9']) then
    begin
      Result := False;
      ShowMessage('Only enter Integers for Doctor ID  please!');
      exit;
    end;

  end;
  Result := True;
end;

function TfrmMainProj.IsValidFirstName(sFirstName: String): Boolean;
var
  I, iPos, K: Integer;
begin

  for K := 1 to Length(sFirstName) do
  begin
    iPos := Pos(' ', sFirstName);
    Delete(sFirstName, iPos, 1);
  end;

  if sFirstName = '' then
  begin
    Result := False;
    ShowMessage('Nothing was entered for the first name');
    exit;
  end;

  for I := 1 to Length(sFirstName) do
  begin

    if not(sFirstName[I] in ['A' .. 'Z', 'a' .. 'z']) then
    begin
      Result := False;
      ShowMessage('Please only enter String for the First Name');
      exit;
    end;
  end;

  Result := True;
end;

function TfrmMainProj.IsValidGender(sGender: String): Boolean;
begin
  if Length(sGender) = 1 then
  begin
    if (sGender = 'M') OR (sGender = 'F') then
    begin
      Result := True;

    end
    else
    begin
      ShowMessage('Please only enter M or F to indicate gender');
      Result := False;

    end;

  end
  else
  begin
    ShowMessage('Please only enter 1 character');
    Result := False;
  end;
end;

function TfrmMainProj.IsValidID(sID: String): Boolean;
var
  I: Integer;

begin

  if sID = '' then
  begin
    Result := False;
    ShowMessage('Nothing was entered for the ID number');
    exit;
  end;

  if Length(sID) = 13 then
  begin
    for I := 1 to 13 do
    begin
      if not(sID[I] in ['0' .. '9']) then
      begin

        Result := False;
        ShowMessage('ID number can only contain numbers!');
        exit;
      end;

    end;

  end
  else
  begin
    ShowMessage('Not correct length!');
    Result := False;
    exit;
  end;

  Result := True;

end;

function TfrmMainProj.IsValidRoomNum(sRoomNum: String): Boolean;
var
  I: Integer;
begin

  if sRoomNum = '' then
  begin
    Result := False;
    ShowMessage('Nothing was entered for the room number');
    exit;
  end;

  for I := 1 to Length(sRoomNum) do
  begin
    if not(sRoomNum[I] in ['0' .. '9']) then
    begin
      Result := False;
      ShowMessage('Only enter Integers for room number please!');
      exit;
    end;

  end;
  Result := True;
end;

function TfrmMainProj.IsValidSurname(sSurname: String): Boolean;
var
  I, K, iPos: Integer;
begin

  for K := 1 to Length(sSurname) do
  begin
    iPos := Pos(' ', sSurname);
    Delete(sSurname, iPos, 1);
  end;

  if sSurname = '' then
  begin
    Result := False;
    ShowMessage('Nothing was entered for the surname');
    exit;
  end;

  for I := 1 to Length(sSurname) do
  begin

    if not(sSurname[I] in ['A' .. 'Z', 'a' .. 'z']) then
    begin
      Result := False;
      ShowMessage('Please only enter String for the surname');
      exit;
    end;
  end;

  Result := True;
end;

procedure TfrmMainProj.LoadTextFile(sTextfile: String);
var
  tFile: Textfile;
  iPos, I, iPrice: Integer;
  sLine, sItem: String;
begin

  for I := 1 to 50 do
  begin
    arrItemName[I] := '';
    arrItemPrice[I] := 0;
  end;

  iCounter := 0;

  if FileExists(sTextfile) then
  begin
    AssignFile(tFile, sTextfile);
  end
  else
  begin
    ShowMessage('File does not exist');
    exit;
  end;

  Reset(tFile);

  while not Eof(tFile) do
  begin
    Inc(iCounter);
    Readln(tFile, sLine);
    iPos := Pos('#', sLine);

    sItem := Copy(sLine, 1, iPos - 1);
    Delete(sLine, 1, iPos);
    iPrice := StrToInt(sLine);

    arrItemName[iCounter] := sItem;
    arrItemPrice[iCounter] := iPrice;

  end;

  CloseFile(tFile);
end;

procedure TfrmMainProj.Logout1Click(Sender: TObject);
begin

  if bLoggedIn = True then
  begin
    ShowMessage('Logging out!');
    bLoggedIn := False;

    tsMain.Pages[0].TabVisible := True;
    tsMain.ActivePageIndex := 0;
    tsMain.Pages[1].TabVisible := False;
    tsMain.Pages[2].TabVisible := False;
    tsMain.Pages[3].TabVisible := False;
    tsMain.Pages[4].TabVisible := False;
  end
  else
    ShowMessage('Please Login!');
end;

procedure TfrmMainProj.rbgDocterSortClick(Sender: TObject);
begin
  with dmHospital do
  begin
    case rbgDocterSort.ItemIndex of
      0:
        tblDocters.Sort := 'DocterSurname ASC';
      1:
        tblDocters.Sort := 'DocterName ASC';
      2:
        tblDocters.Sort := 'DocterField ASC';

    end;
  end;
end;

procedure TfrmMainProj.rbgPatientSortClick(Sender: TObject);
begin
  with dmHospital do
  begin
    case rbgPatientSort.ItemIndex of
      0:
        tblPatients.Sort := 'PatientSurname ASC';
      1:
        tblPatients.Sort := 'PatientFirstName ASC';

    end;
  end;
end;

procedure TfrmMainProj.spnAmountBottleChange(Sender: TObject);
begin

  if (spnMedID.Value < 0) OR (spnAmountBottle.Value < 0) then
  begin
    spnMedID.Value := 0;
    spnAmountBottle.Value := 0;
  end;

  if (spnMedID.Value <= 0) OR (spnAmountBottle.Value <= 0) then
  begin
    btnBuyMeds.Enabled := False;

  end
  else
    btnBuyMeds.Enabled := True;
end;

procedure TfrmMainProj.spnMedIDChange(Sender: TObject);
begin

  if (spnMedID.Value < 0) OR (spnAmountBottle.Value < 0) then
  begin
    spnMedID.Value := 0;
    spnAmountBottle.Value := 0;
  end;

  if (spnMedID.Value <= 0) OR (spnAmountBottle.Value <= 0) then
  begin
    btnBuyMeds.Enabled := False;

  end
  else
    btnBuyMeds.Enabled := True;
end;

procedure TfrmMainProj.TimerDateTimer(Sender: TObject);
var
  sDateTime: String;
begin
  sDateTime := DateTimeToStr(Now);

  pnlDate.Caption := sDateTime;

  tsMain.Left := (frmMainProj.Width - tsMain.Width) DIV 2;
  tsMain.Top := ((frmMainProj.Height - tsMain.Height) DIV 2) - 35;
end;

end.
