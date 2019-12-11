codeunit 50108 "Revert Management"
{
    procedure RevertText(textValue: Text): Text
    var
        httpClient: HttpClient;
        httpResponse: HttpResponseMessage;
        outputText: Text;
        funcUrl: Label 'https://saasdotnetdll.azurewebsites.net/api/ReverseString?code=c1TGh2iQXHIBCpfcYETsgWy2DDxbuxzH9abHdBzvAAziaaHoTVhEHQ==&text=';
        ParameterError: Label 'Invalid text parameter.';
    begin
        if textValue <> '' then begin
            httpClient.Get(funcUrl + textValue, httpResponse);
            httpResponse.Content().ReadAs(outputText);
            exit(outputText);
        end
        else
            Error(ParameterError);
    end;
}