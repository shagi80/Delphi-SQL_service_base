unit ImportWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, ComCtrls, ToolWin, ExtCtrls, StdCtrls, Buttons, DB, ADODB,
  Menus, ActnList;

type
  TImpError = record
    c,r  : integer;
    err  : string;
  end;
  TImpErrList = array of TImpError;

  TImportFrame = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    CloseBtn: TSpeedButton;
    CaptioLb: TLabel;
    Image1: TImage;
    Panel3: TPanel;
    ChildToolBar: TToolBar;
    PasteFromExcelBtn: TToolButton;
    PasteFromExcelBtnBefore: TToolButton;
    ToolButton6: TToolButton;
    InsRowToTableBeforeBtn: TToolButton;
    ToolButton5: TToolButton;
    ToolButton1: TToolButton;
    ToolButton7: TToolButton;
    InsColToTableBeforeBtn: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ColNameMenu: TPopupMenu;
    itm11: TMenuItem;
    itm21: TMenuItem;
    table: TStringGrid;
    NewBtn: TToolButton;
    ToolButton9: TToolButton;
    Panel4: TPanel;
    OKBtn: TBitBtn;
    BottomCloseBtn: TBitBtn;
    OpenDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    OpenBtn: TToolButton;
    SaveBtn: TToolButton;
    SaveAsBtn: TToolButton;
    StatusLb: TLabel;
    CutBtn: TToolButton;
    CopyBtn: TToolButton;
    PasteBtn: TToolButton;
    PasteFromExcelBtnAfter: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    VerBtn: TToolButton;
    SetAllColNameBtn: TToolButton;
    procedure DeleteColFromTableExecute(Sender: TObject);
    procedure DeleteRowFromTableExecute(Sender: TObject);
    procedure InserColToTableAfterExecute(Sender: TObject);
    procedure InsertRowsToTableAfterExecute(Sender: TObject);
    procedure PasteFromExcelAfterExecute(Sender: TObject);
    procedure PasteFromExcelBeforeExecute(Sender: TObject);
    procedure PasteFromExcelExecute(Sender: TObject);
    procedure PasteToTableFromExcel(mode: Word);
    procedure TableDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ColNameMenuClick(Sender: TObject);
    procedure TableSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure PrepareFrame;
    procedure TableMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure InsertColToTable(top,cnt:integer);
    procedure InsertRowToTable(top,cnt:integer);
    procedure CopyTableToClipBrd(Sender: TObject);
    procedure CutToTable(Sender: TObject);
    procedure PasteToTable(Sender: TObject);
    procedure LoadTableFromFile(Sender: TObject);
    procedure InsColToTableBeforeBtnClick(Sender: TObject);
    procedure InsRowToTableBeforeBtnClick(Sender: TObject);
    function  VerifyImportFormat: boolean;
    function  PointToImpErrorLst(ErArr :TImpErrList;x,y:integer):integer;
    procedure TableModify(md:boolean);
    procedure NewBtnClick(Sender: TObject);
    procedure DeleteRowFromTable(top,cnt:integer);
    procedure DeleteColFromTable(top,cnt:integer);
    function  ClearTable(const showdlg:boolean=true):boolean;
    procedure SaveToFile(Sender: TObject);
    procedure SaveAsBtnClick(Sender: TObject);
    procedure tableSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure UpdatePasteBtn;
    procedure OKBtnClick(Sender: TObject);
    procedure tableContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure VerBtnClick(Sender: TObject);
    procedure SetAllColNameBtnClick(Sender: TObject);
  private
    { Private declarations }
    ErrLst : TImpErrList;
    fname  : string;
  public
    { Public declarations }
    TableModified : boolean;
  end;

implementation

{$R *.dfm}

uses DataMod, Clipbrd;

procedure TImportFrame.PrepareFrame;
var
  mi : TMenuItem;
begin
  //заполнение всплывающего меню со сппском полей
  ColNameMenu.Items.Clear;
  mi:=TMenuItem.Create(ColNameMenu);
  mi.Caption:='нет';
  mi.Tag:=0;
  mi.OnClick:=ColNameMenuClick;
  ColNameMenu.Items.Add(mi);
  DMod.FieldsTable.First;
  while not DMod.FieldsTable.Eof do begin
    mi:=TMenuItem.Create(ColNameMenu);
    mi.Caption:=DMod.FieldsTable.FieldByName('DESCR').AsString;
    mi.Tag:=DMod.FieldsTable.FieldByName('ID').AsInteger;
    mi.OnClick:=ColNameMenuClick;
    ColNameMenu.Items.Add(mi);
    DMod.FieldsTable.Next;
  end;
  fname:='';
  //установка ширины первого стобца и отмена выделения по умолчанию
  table.ColWidths[0]:=20;
  table.Cells[0,1]:='1';
  table.Selection:=TGridRect(rect(-1,-1,-1,-1));
  //
  CutBtn.Enabled:=false;
  CopyBtn.Enabled:=false;
  self.TableModify(false);
end;

procedure TImportFrame.UpdatePasteBtn;
begin
  PasteBtn.Enabled:=(Length(Clipboard.AsText)>0);
  PasteFromExcelBtn.Enabled:=(Length(Clipboard.AsText)>0);
  PasteFromExcelBtnAfter.Enabled:=(Length(Clipboard.AsText)>0);
  PasteFromExcelBtnBefore.Enabled:=(Length(Clipboard.AsText)>0);
end;

procedure TImportFrame.TableModify(md:boolean);
begin
  TableModified :=md;
  SaveBtn.Enabled:=md;
  SaveASBtn.Enabled:=md;
  VerBtn.Enabled:=md;
  OKBtn.Enabled:=md;
  if TableModified then begin
    StatusLB.Font.Style:=[];
    StatusLB.Font.Color:=clBlack;
    StatusLB.Caption:='Таблица не проверена!';
  end else begin
    TableModified:=false;
    StatusLB.Caption:='';
  end;
end;

procedure TImportFrame.DeleteColFromTableExecute(Sender: TObject);
begin
  self.DeleteColFromTable(table.Selection.Left,table.Selection.Right-table.Selection.Left+1);
  TableModify(true);
  self.VerifyImportFormat;
end;

procedure TImportFrame.DeleteRowFromTableExecute(Sender: TObject);
begin
  self.DeleteRowFromTable(table.Selection.Top,table.Selection.Bottom-table.Selection.Top+1);
  TableModify(true);
  self.VerifyImportFormat;
end;

procedure TImportFrame.InserColToTableAfterExecute(Sender: TObject);
begin
  if table.Selection.Left>0 then begin
    InsertColToTable(table.Selection.Left,Table.Selection.Right-table.Selection.Left+1);
    TableModify(true);
  end;
end;

procedure TImportFrame.InsertRowsToTableAfterExecute(Sender: TObject);
begin
  if table.Selection.Top>0 then begin
    InsertRowToTable(table.Selection.Top,Table.Selection.Bottom-table.Selection.Top+1);
    TableModify(true);
  end;
end;

procedure TImportFrame.PasteFromExcelAfterExecute(Sender: TObject);
begin
  self.PasteToTableFromExcel(2);
  TableModify(true);
end;

procedure TImportFrame.PasteFromExcelBeforeExecute(Sender: TObject);
begin
  self.PasteToTableFromExcel(1);
  TableModify(true);
end;

procedure TImportFrame.VerBtnClick(Sender: TObject);
begin
  VerifyImportFormat;
end;

function TImportFrame.ClearTable(const showdlg:boolean=true) : boolean;
begin
  result:=false;
  if (not showdlg)or((showdlg)and(MessageDlg('Данные в существующей таблице будут утеряны. Продолжить?',
    mtWarning,[mbYes,mbCancel],0)=mrYes)) then begin
      SetLength(ErrLst,0);
      self.DeleteRowFromTable(1,table.RowCount-1);
      self.DeleteColFromTable(1,table.ColCount-1);
      self.TableModify(false);
      result:=true;
    end;
end;

procedure TImportFrame.PasteFromExcelExecute(Sender: TObject);
begin
  if (length(StatusLB.Caption)=0)or((length(StatusLB.Caption)>0)and(self.ClearTable)) then begin
      PasteToTableFromExcel(0);
      TableModify(true);
    end;
end;

procedure TImportFrame.TableDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  str : string;
  rct : TRect;
begin
  if (PointToImpErrorLst(ErrLst,ACol,ARow)>-1) then begin
    str:=Table.Cells[ACol,Arow];
    rct:=rect;
    Table.Canvas.Brush.Color:=clERROR;
    Table.Canvas.FillRect(rct);
    inc(rct.Top,2);
    inc(rct.Left,2);
    DrawText(Table.Canvas.Handle,pchar(str),Length(str),rct,0);
  end;
end;

procedure TImportFrame.TableMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  crd : TGridCoord;
begin
  crd:=Table.MouseCoord(X,Y);
  //шелчок по заголовку столбца - левая кнопка выдлеение столбца
  if (crd.Y=0)and(crd.X>=Table.FixedCols) then if Button=mbLeft then begin
    Table.Selection:=TGridRect(rect(crd.X,Table.FixedRows,crd.X,Table.RowCount-1));
  end;
  //шелчок по заголовку строки левая кнопка мыши - выделение строки
  if (crd.X=0)and(crd.Y>=Table.FixedRows) then if Button=mbLeft then begin
    //левая кнопка мыши - выделение строки
    Table.Selection:=TGridRect(rect(Table.FixedCols,crd.Y,Table.ColCount-1,crd.Y));
  end;
end;

procedure TImportFrame.tableSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  CutBtn.Enabled:=true;
  CopyBtn.Enabled:=true;
end;

procedure TImportFrame.TableSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  TableModify(true);
 end;

procedure TImportFrame.SetAllColNameBtnClick(Sender: TObject);
var
  c   : integer;
  pid : ^integer;
begin
  DMod.FieldsTable.First;
  c:=1;
  while(not DMod.FieldsTable.Eof)and(c<Table.ColCount) do begin
    Table.ColWidths[c]:=DMod.FieldsTable.FieldByName('DISPLEN').AsInteger;
    Table.Cells[C,0]:=DMod.FieldsTable.FieldByName('DESCR').AsString;
    new(pid);
    pid^:=DMod.FieldsTable.FieldByName('ID').AsInteger;
    Table.Objects[c,0]:=TObject(pid);
    DMod.FieldsTable.Next;
    inc(c);
  end;
  TableModify(true);
  self.VerifyImportFormat;
end;

procedure TImportFrame.InsRowToTableBeforeBtnClick(Sender: TObject);
begin
  if table.Selection.Top>0 then begin
    InsertRowToTable(table.Selection.Top-1,Table.Selection.Bottom-table.Selection.Top+1);
    TableModify(true);
  end;
end;

procedure TImportFrame.InsColToTableBeforeBtnClick(Sender: TObject);
begin
  if table.Selection.Left>0 then begin
    InsertColToTable(table.Selection.Left-1,Table.Selection.Right-table.Selection.Left+1);
    TableModify(true);
  end;
end;

procedure TImportFrame.NewBtnClick(Sender: TObject);
begin
    if Length(StatusLB.Caption)>0 then self.ClearTable(true);
end;

procedure TImportFrame.OKBtnClick(Sender: TObject);
begin

end;

//вставка из Excel
procedure TImportFrame.PasteToTableFromExcel(mode: Word);
var
  c,r : integer;
  buf : TStringList;
  str : string;
begin
  Clipboard.Open;
  if Length(Clipboard.AsText)>0 then begin
    buf:=TStringList.Create;
    buf.Text:=Clipboard.AsText;
    Clipboard.Close;
    case mode of
    0: begin //вставка вместо
        table.RowCount:=buf.Count+1;
        Table.Selection:=TGridRect(rect(1,1,1,1));
    end;
    1: begin //вставка перед
        InsertRowToTable(0,buf.Count);
        Table.Selection:=TGridRect(rect(1,1,1,1));
    end;
    2: begin //вставка после
        table.RowCount:=table.RowCount+buf.Count;
        Table.Selection:=TGridRect(rect(1,table.RowCount-buf.Count,1,table.RowCount-buf.Count));
    end;
    end;
    str:=buf[0];
    c:=0;
    repeat
      inc(c);
      delete(str,1,pos(#9,str));
    until pos(#9,str)=0;
    table.ColCount:=c+2;
    PasteToTable(self);
    for r := 1 to table.RowCount - 1 do table.Cells[0,r]:=IntToStr(r);
    table.Selection:=TGridRect(rect(-1,-1,-1,-1));
    TableModified:=true;
  end else Clipboard.Close;
end;

//назначение столбца
procedure TImportFrame.ColNameMenuClick(Sender: TObject);
var
  crd   : Tpoint;
  c,id  : integer;
  pid   : ^integer;
begin
  if (sender as TMenuItem).Checked=false then begin
    crd:=table.ScreenToClient(ColNameMenu.PopupPoint);
    c:=table.MouseCoord(crd.X,crd.y).X;
    Table.Cells[C,0]:=(sender as TMenuItem).Caption;
    id:=(sender as TMenuItem).Tag;
    if DMod.FieldsTable.Lookup('ID',ID,'ID')=NULL then id:=0;
    if id=0 then  Table.ColWidths[c]:=30
      else Table.ColWidths[c]:=integer(DMod.FieldsTable.Lookup('ID',ID,'DISPLEN'));
    new(pid);
    pid^:=id;
    Table.Objects[c,0]:=TObject(pid);
    TableModify(true);
    self.VerifyImportFormat;
  end;
end;

//вставка столбцов в таблицу
procedure TImportFrame.InsertColToTable(top,cnt:integer);
var
  c : integer;
begin;
  table.ColCount:=table.ColCount+cnt;
  top:=top+1;
  if top<table.ColCount then begin
    for c := table.ColCount-1 downto top+cnt do begin
      table.Cols[c]:=table.Cols[c-cnt];
      table.Objects[c,0]:=table.Objects[c-cnt,0];
      table.ColWidths[c]:=table.ColWidths[c-cnt];
    end;
    for c := top to top+cnt-1 do begin
      table.Cols[c].Clear;
      table.ColWidths[c]:=table.DefaultColWidth;
      table.Objects[c,0]:=nil;
    end;
  end;
  table.Selection:=TGridRect(rect(-1,-1,-1,-1));
end;

//вставка строк в таблицу
procedure TImportFrame.InsertRowToTable(top,cnt:integer);
var
  r : integer;
begin;
  table.RowCount:=table.RowCount+cnt;
  top:=top+1;
  if top<table.RowCount then begin
    for r := table.RowCount-1 downto top+cnt do table.Rows[r]:=table.Rows[r-cnt];
    for r := top to top+cnt-1 do table.Rows[r].Clear;
  end;
  table.Selection:=TGridRect(rect(-1,-1,-1,-1));
  for r := 1 to table.RowCount - 1 do table.Cells[0,r]:=IntToStr(r);
end;

//общая процедура копирования из таблицы в буфер
procedure TImportFrame.CopyTableToClipBrd(Sender: TObject);
var
  c,r:integer;
begin
  if (table.Selection.Top<1)or(table.Selection.Left<1) then Abort;
  Clipboard.Open;
  Clipboard.Clear;
  for r := table.Selection.Top to table.Selection.Bottom do begin
    for c := table.Selection.Left  to table.Selection.Right do begin
        Clipboard.AsText:=Clipboard.AsText+table.Cells[c,r];
        if c<table.Selection.Right then Clipboard.AsText:=Clipboard.AsText+#9;
      end;
    Clipboard.AsText:=Clipboard.AsText+#13#10;
  end;
  PasteBtn.Enabled:=(Length(Clipboard.AsText)>0);
  Clipboard.Close;
end;

//общая процедура удаления из таблицы
procedure TImportFrame.CutToTable(Sender: TObject);
var
  c,r:integer;
begin
  if (table.Selection.Top<1)or(table.Selection.Left<1) then Abort;  
  self.CopyTableToClipBrd(sender);
  for r := table.Selection.Top to table.Selection.Bottom do
    for c := table.Selection.Left  to table.Selection.Right do table.Cells[c,r]:='';
end;

//общая процедура вставки в таблицу
procedure TImportFrame.PasteToTable(Sender: TObject);
var
  c,r,s,i :integer;
  buf : TStringList;
  str : string;
  EOR : boolean;
begin
  Clipboard.Open;
  if Length(Clipboard.AsText)>0 then begin
    buf:=TstringList.Create;
    buf.Text:=Clipboard.AsText;
    r:=table.Selection.Top;
    if r<1 then r:=1;    
    s:=0;
    while (r<table.RowCount)and(s<buf.Count) do begin
      EOR:=false;
      c:=table.Selection.Left;
      if c<1 then c:=1;
      while(c<table.ColCount)and(not EOR)do begin
        i:= pos(#9,buf[s]);
        if (i<>0) then begin
          str:=copy(buf[s],1,i-1);
          buf[s]:= copy(buf[s],i+1,MaxInt);
        end else begin
          str:=buf[s];
          EOR:=true;
        end;
        table.Cells[c,r]:=str;
        inc(c);
      end;
      inc(r);
      inc(s);
    end;
    buf.Free;
  end else MessageDlg('Недопустимый формат в буфере обмена !',mtError,[mbok],0);
  Clipboard.Close;
end;

//сохранить как
procedure TImportFrame.SaveAsBtnClick(Sender: TObject);
begin
  if not self.TableModified then Abort;
  if self.SaveDlg.Execute then  fname:=SaveDlg.FileName else Abort;
  self.SaveToFile(sender);
end;

//сохранение в текстовый файл
procedure TImportFrame.SaveToFile(Sender: TObject);
var
  c,r  : integer;
  str  : string;
  Strs : TStringList;
  pint : ^integer;
begin
  if not self.TableModified then Abort;
  if(length(fname)=0)or((length(fname)>0)and(not FileExists(fname)))then
    if self.SaveDlg.Execute then  fname:=SaveDlg.FileName else Abort;
  Strs:=TStringList.Create;
  //кол-во столбцов и их ID
  Strs.Add(inttostr(table.ColCount-1));
  str:='';
  for c := 1 to table.ColCount-1 do begin
    if table.Objects[c,0]<>nil then pint:=pointer(table.Objects[c,0]) else pint^:=-1;
    str:=str+inttostr(pint^);
    if c<table.ColCount-1 then str:=str+chr(9);
  end;
  Strs.Add(str);
  //содержимое
  for r := 1 to table.RowCount-1 do begin
    str:='';
    for c := 1 to table.ColCount-1 do begin
        str:=str+table.Cells[c,r];
        if c<table.ColCount-1 then str:=str+chr(9);
      end;
    Strs.Add(str);
  end;
  Strs.SaveToFile(fname);
  Strs.Free;
end;

procedure TImportFrame.tableContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  c,i   : integer;
  str   : string;
  fldID : ^integer;
begin
  //отметка в сплывающем меню названий столбцов, которые уже есть в таблице
  //если стоблец отмечен - его нельзя выбрать
  if ((Table.MouseCoord(MousePos.X,MousePos.Y).y=0)and(Table.MouseCoord(MousePos.X,MousePos.Y).X>0)) then begin
    for I := 1 to ColNameMenu.Items.Count - 1 do begin
      c:=1;
      ColNameMenu.Items[i].Checked:=false;
      if table.Objects[c,0]<>nil then begin
        fldID:=Pointer(table.Objects[c,0]);
        if fldID^>0 then str:=DMod.FieldsTable.Lookup('ID',fldID^,'DESCR') else str:='';
      end;
      while(c<table.ColCount)and(str<>ColNameMenu.Items[i].Caption)do begin
        inc(c);
        if table.Objects[c,0]<>nil then begin
          fldID:=Pointer(table.Objects[c,0]);
          if fldID^>0 then str:=DMod.FieldsTable.Lookup('ID',fldID^,'DESCR') else str:='';
        end else str:='';
      end;
      if(c<table.ColCount)then
        ColNameMenu.Items[i].Checked:=((table.Cells[c,0]=ColNameMenu.Items[i].Caption));
    end;
    Table.PopupMenu:=ColNameMenu;
  end else Table.PopupMenu:=nil;
end;

//загрузка из вфйла
procedure TImportFrame.LoadTableFromFile(Sender: TObject);
var
  str,substr : string;
  i,c,r      : integer;
  strs       : TStringList;
  pid        : ^integer;
begin
  if Length(StatusLB.Caption)>0 then
    if MessageDlg('Данные в существующей таблице будут утеряны. Продолжить?',
      mtWarning,[mbYes,mbCancel],0)=mrCancel then Abort;
  if (OpenDlg.Execute)and(FileExists(OpenDlg.FileName)) then begin
    self.ClearTable(false);
    fname:=OpenDlg.FileName;
    Strs:=TStringList.Create;
    Strs.LoadFromFile(fname);
    Table.ColCount:=strtoint(Strs[0])+table.FixedCols;
    Table.RowCount:=table.FixedRows+strs.Count-2;
    //ID столбцов
    str:=Strs[1];
    c:=1;
    while Length(str)>0 do begin
      i:=pos(chr(9),str);
      if i=0 then i:=maxint;
      substr:=copy(str,1,i-1);
      delete(str,1,i);
      i:=strtointdef(substr,0);
      if i=0 then begin
        Table.ColWidths[c]:=30;
        new(pid);
        pid^:=0;
        Table.Objects[c,0]:=TObject(pid);
        Table.Cells[c,0]:='нет';
      end else if DMod.FieldsTable.Lookup('ID',I,'ID')<>NULL then begin
        Table.ColWidths[c]:=integer(DMod.FieldsTable.Lookup('ID',I,'DISPLEN'));
        new(pid);
        pid^:=i;
        Table.Objects[c,0]:=TObject(pid);
        Table.Cells[c,0]:=DMod.FieldsTable.Lookup('ID',I,'DESCR');
      end;
      inc(c);
      if Length(str)>0 then table.ColCount:=c+1;
    end;
    //содержимое
    for r := 2 to Strs.Count - 1 do begin
      str:=Strs[r];
      Table.Cells[0,r-1]:=inttostr(r-1);
      c:=1;
      while Length(str)>0 do begin
        i:=pos(chr(9),str);
        if i=0 then i:=maxint;
        substr:=copy(str,1,i-1);
        delete(str,1,i);
        Table.Cells[c,r-1]:=substr;
        inc(c);
      end;
    end;
    Strs.Free;
    self.TableModify(true);
  end else fname:='';
end;

//Удалить столбцы в таблице
procedure TImportFrame.DeleteColFromTable(top,cnt:integer);
var
  r : integer;
begin
  if top>0 then begin
    if cnt=table.ColCount-table.FixedCols then begin
      table.ColCount:=table.FixedRows+1;
      table.Cols[1].Clear;
      table.ColWidths[1]:=table.DefaultColWidth;
      table.Objects[1,0]:=nil;
    end else begin
      for r := 0 to table.ColCount-top-cnt-1 do begin
        table.Cols[top+r]:=table.Cols[top+cnt+r];
        table.Objects[top+r,0]:=table.Objects[top+cnt+r,0];
        table.ColWidths[top+r]:=table.ColWidths[top+cnt+r];
      end;
      table.ColCount:=table.ColCount-cnt;
    end;
    table.Selection:=TGridRect(rect(-1,-1,-1,-1));
  end;
end;

//Удалить строки в таблице
procedure TImportFrame.DeleteRowFromTable(top,cnt:integer);
var
  r : integer;
begin
  if top>0 then begin
    if cnt=table.RowCount-table.FixedRows then begin
      table.RowCount:=table.FixedCols+1;
      table.Rows[1].Clear;
    end else begin
      for r := 0 to table.RowCount-top-cnt-1 do table.Rows[top+r]:=table.Rows[top+cnt+r];
      table.RowCount:=table.RowCount-cnt;
    end;
    table.Selection:=TGridRect(rect(-1,-1,-1,-1));
    for r := 1 to table.RowCount - 1 do table.Cells[0,r]:=IntToStr(r);
  end;
end;

//ПРОВЕРКИ ОТЧЕТА --------------------------------------------------------------

function TImportFrame.PointToImpErrorLst(ErArr :TImpErrList;x,y:integer):integer;
var
  i : integer;
begin
  if high(ErArr)>-1 then begin
    i:=0;
    while(i<=high(ErArr))and(not((ErArr[i].c=X)and(ErArr[i].r=Y)))do inc(i);
    if (i>high(ErArr)) then result:=-1 else result:=i;
  end else result:=-1;
end;

function TImportFrame.VerifyImportFormat:boolean;
var
  c,r,vt  : integer;
  pid     : ^integer;
  val     : string;

procedure AddToErrList (err:string);
begin
  SetLength(ErrLst,high(errlst)+2);
  errlst[high(errlst)].c:=c;
  errlst[high(errlst)].r:=r;
  errlst[high(errlst)].err:=err;
end;

begin
  result:=true;
  //проверка назначения столбцов
  c:=1;
  val:='';
  repeat
    pid:=Pointer(Table.Objects[c,0]);
    if (pid<>nil)and(pid^>0) then val:='find' else inc(c);
  until (c>=Table.ColCount)or(Length(val)>0);
  if Length(val)=0 then begin
    MessageDlg('Ни один столбец не назначен !',mtError,[mbOk],0);
    result:=false;
    Abort;
  end;
  //праверка наличия данных
  r:=1;
  val:='';
  repeat
    c:=1;
    repeat
      if Length(Table.Cells[c,r])>0 then val:='find' else inc(c);
    until (c>=Table.ColCount)or(Length(val)>0);
    inc(r);
  until (r>=Table.RowCount)or(Length(val)>0);
  if  Length(val)=0 then begin
    MessageDlg('Таблица пуста !',mtError,[mbOk],0);
    result:=false;
    Abort;
  end;
  //удаляем пустые строки
  r:=1;
  repeat
    c:=1;
    while (c<Table.ColCount)and(Length(Table.Cells[c,r])=0) do inc(c);
    if(c=Table.ColCount)then self.DeleteRowFromTable(r,1)else inc(r);
  until r>=Table.RowCount;
  //проверка форатов дат и чисел
  SetLength(ErrLst,0);
  for c := 1 to Table.ColCount - 1 do begin
    pid:=Pointer(Table.Objects[c,0]);
    if (pid<>nil)and(pid^>0) then begin
      vt:=Integer(DMod.FieldsTable.Lookup('ID',pid^,'VTYPE'));
      if vt>0 then for r := 1 to Table.RowCount - 1 do begin
        val:=Table.Cells[c,r];
        case vt of
          1 : if length(val)>0 then begin
              val:=StringReplace(val,chr(32), '',[rfReplaceAll, rfIgnoreCase]);
              val:=StringReplace(val,'г', '',[rfReplaceAll, rfIgnoreCase]);
              val:=StringReplace(val,chr(44),chr(46),[rfReplaceAll, rfIgnoreCase]);
              val:=StringReplace(val,chr(47),chr(46),[rfReplaceAll, rfIgnoreCase]);
              val:=StringReplace(val,'-','',[rfReplaceAll, rfIgnoreCase]);
              Table.Cells[c,r]:=val;
              if (length(val)>0)then
                if(StrToDateDef(val,0)=0) then AddToErrList('ошибка преобразования даты')
                  else if (StrToDateDef(val,0)>StrToDate('01.01.2030'))or(StrToDateDef(val,0)<StrToDate('01.01.2010'))
                    then AddToErrList('дата вне диапазона');
              end;
          2 : if length(val)>0 then begin
              val:=StringReplace(val,chr(32), '',[rfReplaceAll, rfIgnoreCase]);
              val:=StringReplace(val,chr(160), '',[rfReplaceAll, rfIgnoreCase]);
              val:=StringReplace(val,chr(46), chr(44),[rfReplaceAll, rfIgnoreCase]);
              Table.Cells[c,r]:=val;
              if (StrToFloatDef(val,-1)=-1) then AddToErrList('ошибка преобразования числа');
              end;
          3 : begin
              val:=StringReplace(val,'-','',[rfReplaceAll, rfIgnoreCase]);
              Table.Cells[c,r]:=val;
              end;
        end;
      end;
    end;
  end;
  if high(ErrLst)>=0 then begin
    StatusLB.Font.Style:=[fsBold];
    StatusLB.Font.Color:=clRed;
    StatusLB.Caption:='В таблице обнаружены ошибки !';
    result:=false;
  end else begin
    StatusLB.Font.Style:=[fsBold];
    StatusLB.Font.Color:=clGreen;
    StatusLB.Caption:='Таблица проверена. Ошибок нет !';
  end;
  Table.Repaint;
end;


end.
