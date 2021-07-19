object dmHospital: TdmHospital
  OldCreateOrder = False
  Height = 467
  Width = 864
  object conDatabase: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=HospitalDatabase.md' +
      'b;Mode=ReadWrite;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 136
    Top = 144
  end
  object tblMeds: TADOTable
    Active = True
    Connection = conDatabase
    CursorType = ctStatic
    TableName = 'tblMedicine'
    Left = 240
    Top = 144
  end
  object tblDocters: TADOTable
    Active = True
    Connection = conDatabase
    CursorType = ctStatic
    TableName = 'tblDocters'
    Left = 240
    Top = 232
  end
  object tblPatients: TADOTable
    Active = True
    Connection = conDatabase
    CursorType = ctStatic
    TableName = 'tblPatients'
    Left = 240
    Top = 328
  end
  object dscMeds: TDataSource
    DataSet = tblMeds
    Left = 336
    Top = 144
  end
  object dscDocters: TDataSource
    DataSet = tblDocters
    Left = 336
    Top = 232
  end
  object dscPatients: TDataSource
    DataSet = tblPatients
    Left = 336
    Top = 328
  end
end
