Sub TDD()
    Dim first As Integer
    Dim last As Integer
    Dim rng As String
    Sheets("Sheet1").Activate
    Range("A1").Select
    first = Selection.Row
    Do While (True)
        Dim sectionName As String
        sectionName = Cells(first + 1, 1).Value
        If sectionName = "" Then
            Exit Do
        End If
        Dim sectionDesc As String
        sectionDesc = Cells(first + 2, 1).Value
        
        Call NextSection(sectionName, sectionDesc)
        
        Call Search("Methods:")
        last = Selection.Row
        Range("A" + CStr(first + 4) + ":C" + CStr(first + 4)).Select
        Selection.Font.Underline = xlUnderlineStyleSingle
        Call AppendTable("Fields:", "A" + CStr(first + 4) + ":C" + CStr(last - 1))
        
        Call Search("##")
        last = last + 1
        first = Selection.Row
        
        Range("A" + CStr(last) + ":C" + CStr(last)).Select
        Selection.Font.Underline = xlUnderlineStyleSingle
        Call AppendTable("Methods:", "A" + CStr(last) + ":C" + CStr(first - 1))
    Loop
End Sub
Sub Search(what As String)
    Cells.Find(what:=what, After:=ActiveCell, LookIn:=xlFormulas, LookAt:= _
        xlPart, SearchOrder:=xlByRows, SearchDirection:=xlNext, MatchCase:=False _
        , SearchFormat:=False).Activate
End Sub

Sub NextSection(name As String, desc As String)
    Sheets("Sheet2").Activate
    
    ActiveSheet.Shapes("Object 1").Select
    With Selection.Object.Application.Selection
        .TypeText Text:="$$:" + name
        .TypeParagraph
        .TypeText Text:=desc
        .TypeParagraph
    End With
    Sheets("Sheet1").Activate
End Sub
Sub AppendTable(title As String, rng As String)
    Range(rng).Select
    Application.CutCopyMode = False
    Selection.Copy
    
    Sheets("Sheet2").Activate
    
    ActiveSheet.Shapes("Object 1").Select
    With Selection.Object.Application.Selection
        .TypeText Text:=title
        .TypeParagraph
        .PasteExcelTable False, False, False
        .TypeParagraph
    End With
    Sheets("Sheet1").Activate
End Sub






Sub Tablize()
    Dim first As Integer
    Dim last As Integer
    Dim rng As String
    For first = 1 To 1377 Step 8
        Sheets("Sheet1").Activate
        last = first + 6
        rng = "A" + CStr(first) + ":B" + CStr(last)
        
        Range(rng).Select
        Application.CutCopyMode = False
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ColorIndex = 0
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ColorIndex = 0
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ColorIndex = 0
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ColorIndex = 0
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlInsideVertical)
            .LineStyle = xlContinuous
            .ColorIndex = 0
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlInsideHorizontal)
            .LineStyle = xlContinuous
            .ColorIndex = 0
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Copy
        
        Sheets("Sheet2").Activate
        
        ActiveSheet.Shapes("Object 1").Select
        With Selection.Object.Application.Selection
            .PasteExcelTable False, False, False
            .TypeParagraph
        End With
    Next first
End Sub
