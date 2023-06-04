unit PrintMod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, Buttons, StdCtrls, ComCtrls, Mask, DBCtrls,
  CustomizeDlg, Menus, ActnList, Grids, ToolWin, ImportWin, DBGrids, Gauges,
  DateUtils, frxClass, frxDBSet;

type
  TPrMod = class(TDataModule)
    Query1: TADOQuery;
    Query2: TADOQuery;
    DS1: TDataSource;
    DS2: TDataSource;
    frxData2: TfrxDBDataset;
    frxData1: TfrxDBDataset;
    Report: TfrxReport;
    procedure MainGetValue(const VarName: string; var Value: Variant);
    procedure ReportPreview(Sender: TObject);
    procedure SNHistoryDS1DataChange(Sender: TObject; Field: TField);
    procedure ReportClosePreview(Sender: TObject);
  private
    { Private declarations }
    Title, Caption : string;
    Details : Boolean;
  public
    { Public declarations }
    formcaption : string;
  end;


procedure PrintSNHistoryReport(numbers : TStringList);
procedure PrintReport(ID : integer;const onlyfaults: boolean=false);

implementation

uses DataMod;

{$R *.dfm}
{$R MYRES.RES}

//----------------------- ПЕЧАТЬ ОТЧЕТОВ ---------------------------------------

procedure PrintSNHistoryReport(numbers : TStringList);
var
  PrMod          : TPrMod;
  sql            : TStringList;
  filter,sn,
  insert,str     : string;
  i,factoryid    : integer;

begin
  PrMod:=TPrMod.Create(application);
  if Length(numbers.Text)=0 then Abort;
  sql:=TStringList.Create;
  if FileExists(MyPath+'SNHISTORY.txt') then begin
    Sql.LoadFromFile(MyPath+'SNHISTORY.txt');
    if Length(sql.Text)>0 then with PrMod do begin
      formcaption:='История ремонтов';
      filter:='';
      insert:='';
      for I := 0 to numbers.Count - 1 do begin
        sn:=copy(numbers[i],pos('=',numbers[i])+1,maxint);
        factoryid:=strtointdef(copy(numbers[i],1,pos('=',numbers[i])-1),0);
        str:=DMod.DecodeWMSN(sn);
        if Length(str)>0 then begin
          Query1.SQL.Add('SELECT T1.*, T2.[DESCR] FROM NOVATEKPRODCODES AS T1');
          Query1.SQL.Add('INNER JOIN SHOPS AS T2 ON T2.[ID]=T1.[SHOPSID]');
          Query1.SQL.Add('WHERE CODE='+QuotedStr(str));
          case FACTORYID of
            1 : Query1.SQL.Add(' AND (SHOPSID=2 OR SHOPSID=3)');
            2 : Query1.SQL.Add(' AND SHOPSID=4');
          end;
          Query1.Open;
          if Query1.IsEmpty then str:='данные о производстве не найдены'
            else str:='произведено '+FormatDateTime('dd mmm yyyy',Query1.FieldByName('DATETIME').AsDateTime)+
              ' в '+Query1.FieldByName('DESCR').AsString;
          if length(filter)=0 then filter:='AND ((SN='+QuotedStr(sn)+')' else filter:=filter+' OR (SN='+QuotedStr(sn)+')';
          insert:=insert+'INSERT INTO #SNTABLE VALUES ('+QuotedStr(sn)+','+QuotedStr(str)+')'+chr(13);
          Query1.Close;
          Query1.SQL.Clear;
        end else insert:=insert+'INSERT INTO #SNTABLE VALUES ('+QuotedStr(numbers[i])+','+QuotedStr('код не распознан')+')'+chr(13);
      end;
      if Length(filter)>0 then filter:=filter+')';
      sql.Text:=StringReplace(sql.Text,'/INSERT/',INSERT,[rfReplaceAll]);
      DS1.OnDataChange:=SNHistoryDS1DataChange;
      Query1.SQL.Add(sql.Text);
      Query1.Open;
      Report.LoadFromFile(MyPath+'frxSNHistory.fr3');
      Report.ShowReport(true);
    end;
  end;
  sql.Free;
end;

procedure PrintReport(ID : integer; const onlyfaults: boolean=false);
var
  PrMod     : TPrMod;
begin
  PrMod:=TPrMod.Create(application);
  with PrMod do begin
    DS1.OnDataChange:=nil;
    Query2.SQL.Add('SELECT T1.*, T2.DESCR, T2.CITY FROM SERVREPORT AS T1');
    Query2.SQL.Add('INNER JOIN SERVCENTRES AS T2 ON T2.ID=T1.SENTERID');
    Query2.SQL.Add('WHERE (T1.ID='+IntToStr(ID)+')');
    Query2.Open;
    Caption:='Отчет №'+Query2.FieldByName('NUMBER').AsString+' от '+
      FormatDateTime('dd.mm.yy',Query2.FieldByName('DOCDATE').AsDateTime)+' - печать';
    if onlyfaults then title:='ремонты только с ошибками и вопросами' else title:='';
    details:=false;
    Query1.SQL.Add('SELECT * FROM SERVRECORDS WHERE (REPORTID='+IntToStr(ID)+')');
    if onlyfaults then Query1.SQL.Add('AND (STATUS<3)');
    Query1.Open;
    Report.LoadFromFile(MyPath+'frxReport.fr3');
    Report.PrepareReport(true);
    Report.ShowPreparedReport;
  end;
end;

//------------------------------- события отчета -------------------------------

procedure TPrMod.MainGetValue(const VarName: string; var Value: Variant);
begin
  value:='';
  if comparetext(varname,'CAPTION')=0 then value:=AnsiUpperCase(Caption);
  if comparetext(varname,'FILTER')=0 then value:=title;
  if comparetext(varname,'TOTFLTPROC')=0 then
    if Query1.FieldByName('TCNT').AsInteger=0 then value:=''
      else value:='('+FormatFloat('##0.00',Query1.FieldByName('TOTFLT').AsFloat/Query1.FieldByName('TCNT').AsFloat)+'%)';
  if comparetext(varname,'PROCENT')=0 then
    if Query1.FieldByName('TCNT').AsInteger=0 then value:=''
      else value:=FormatFloat('##0.00',Query1.FieldByName('TPCNT').AsFloat*100/Query1.FieldByName('TCNT').AsFloat)+'%';
  if comparetext(varname,'FLTPROC')=0 then
    if Query1.FieldByName('TOTFLT').AsInteger=0 then value:=''
      else value:=FormatFloat('##0.00',Query1.FieldByName('TYPEFLT').AsFloat*100/Query1.FieldByName('TOTFLT').AsFloat)+'%';
  if comparetext(varname,'CNTFLTPROC')=0 then
    if Query1.FieldByName('TPCNT').AsInteger=0 then value:=''
      else value:=FormatFloat(DMod.GetFloatFormat(Query1.FieldByName('TYPEFLT').AsFloat*100/
        Query1.FieldByName('TPCNT').AsFloat,2,5),Query1.FieldByName('TYPEFLT').AsFloat*100/
          Query1.FieldByName('TPCNT').AsFloat)+'%';
  {if comparetext(varname,'ERRORTEXT')=0 then begin
    Report.FindObject('ERRORMEMO').Visible:=true;//(Length(Query1.FieldByName('NOTE').AsString)>0);
    value:=Query1.FieldByName('NOTE').AsString;
  end;                      }
end;

procedure TPrMod.SNHistoryDS1DataChange(Sender: TObject; Field: TField);
begin
  Query2.Close;
  Query2.SQL.Clear;
  Query2.SQL.Add('SELECT T1.*, T3.DESCR AS CENTER, T3.CITY FROM SERVRECORDS AS T1');
  Query2.SQL.Add('INNER JOIN SERVREPORT AS T2 ON T2.[ID]=T1.[REPORTID]');
  Query2.SQL.Add('INNER JOIN SERVCENTRES AS T3 ON T3.[ID]=T2.[SENTERID]');
  Query2.SQL.Add('WHERE (T1.[STATUS]=5) AND (T1.[SN]='+QuotedStr(DS1.DataSet.FieldByName('SN').AsString)+')');
  Query2.Open;
end;

//------------------- Работа с формой предварительного простомотра -------------

procedure TPrMod.ReportClosePreview(Sender: TObject);
begin
  PostMessage(application.MainForm.Handle,WM_CLOSECHILD,Report.PreviewForm.Tag,0);
  Report.Owner.Free;
end;

procedure TPrMod.ReportPreview(Sender: TObject);
begin
  Report.PreviewForm.Tag:=DMod.NewWimID;
  Report.PreviewForm.Caption:=self.formcaption;
  Report.Owner.Name:='Print'+IntToStr(Report.PreviewForm.Tag);
  PostMessage(application.MainForm.Handle,WM_CREATECHILD,Report.PreviewForm.Tag,47);
end;

end.
