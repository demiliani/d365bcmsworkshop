codeunit 50100 ReportManagement
{
    trigger OnRun()
    begin

    end;

    var



    procedure StreamReport(): Text
    var
        outStreamReport: OutStream;
        inStreamReport: InStream;
        Parameters: Text;
        tempBlob: Record TempBlob temporary;
        Base64EncodedString: Text;
    begin
        Parameters := Report.RunRequestPage(Report::MySalesOrder);
        tempBlob.Blob.CreateOutStream(outStreamReport, TextEncoding::UTF8);
        Report.SaveAs(Report::MySalesOrder, Parameters, ReportFormat::Pdf, outStreamReport);
        //tempBlob.Blob.CreateInStream(inStreamReport);
        Base64EncodedString := tempBlob.ToBase64String();
        exit(Base64EncodedString);
    end;

    procedure CallAzureFunctionPrinting(Base64EncodedString: Text; filename: Text; fileExt: Code[10])
    var

        httpClient: HttpClient;
        httpContent: HttpContent;
        jsonBody: text;
        httpResponse: HttpResponseMessage;
        httpHeader: HttpHeaders;
    begin


        jsonBody := ' {"base64":"' + Base64EncodedString + ',"fileName":"' + filename +
        '","fileType":"' + fileExt + '"}';

        httpContent.WriteFrom(jsonBody);
        httpContent.GetHeaders(httpHeader);
        httpHeader.Remove('Content-Type');
        httpHeader.Add('Content-Type', 'application/json');
        httpClient.Post('MyAPIUrl/SaveFile', httpContent, httpResponse);
    end;

}