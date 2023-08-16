table 90011 "product grade sorting line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Defact item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Defact Reason Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            begin
                ReasonCode.Reset();
                if ReasonCode.Get("Defact Reason Code") then begin
                    Validate("Defact Daecription", ReasonCode.Description);
                end;
            end;
        }
        field(6; "Defact Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     productgradesortingheader: Record "product grade sorting header";
            //     productgradesortingline: Record "product grade sorting line";
            //     Item: Record Item;
            //     gradec: Decimal;
            //     gradeScap: Decimal;
            // begin
            //     productgradesortingline.Reset();
            //     productgradesortingline.SetRange("Document No", "Document No");
            //     if productgradesortingline.FindSet() then begin
            //         repeat
            //             gradec += Rec."Defact Qty";
            //         until productgradesortingline.Next() = 0;
            //     end;

            //     productgradesortingheader.Reset();
            //     productgradesortingheader.SetRange("Document No", "Document No");
            //     if productgradesortingheader.FindSet() then begin
            //         if gradec > productgradesortingheader."Grade C" then begin
            //             Error('CCC');
            //         end;
            //     end;
            // end;

            //     productgradesortingline.Reset();
            //     productgradesortingheader.Reset();
            //     productgradesortingheader.SetRange("Document No", Rec."Document No");
            //     if productgradesortingheader.FindSet() then begin
            //         productgradesortingline.Reset();
            //         productgradesortingline.SetRange("Document No", Rec."Document No");
            //         if productgradesortingline.FindSet() then begin

            //             gradec := Rec."Defact Qty";
            //             if gradec > productgradesortingheader."Grade C" then begin
            //                 Error('จำนวนเกิน');
            //             end;

            //             gradeScap := Rec."Defact Qty";
            //             if gradeScap > productgradesortingheader."Grade Scap" then begin
            //                 Error('gggg');
            //             end;
            //         end;

            //     end;
            // end;



        }
        field(7; "Defact Daecription"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "References Production order"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Document No", "Line No")
        {
            Clustered = true;
        }
    }

    var
        NoSeriesLine: Record "No. Series Line";
        NoSeries: Record "No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;


    trigger OnInsert()
    var

    begin

    end;

    trigger OnModify()
    var
        ProductionOrder: Record "Production Order";

    begin
        ProductionOrder.Reset();
        ProductionOrder.SetRange("References Document No", "Document No");
        ProductionOrder.SetRange("References Line No", "Line No");
        if ProductionOrder.FindSet() then begin
            Error('ไม่สามารถแก้ไขเอกสารได้เพราะถูกสร้างไปแล้ว');
            // Error('Unable to edit, this document has already been created.');
        end;

    end;



    trigger OnDelete() // ห้ามลบ LIne 
    var
        ProductionOrder: Record "Production Order";

    begin
        ProductionOrder.Reset();
        ProductionOrder.SetRange("References Document No", "Document No");
        ProductionOrder.SetRange("References Line No", "Line No");
        if ProductionOrder.FindSet() then begin
            Error('ไม่สามรถลบไลน์ได้เพราะเอกสารถูกสร้างไปแล้ว');
            // Error('cannot be deleted because it has already been created');
        end;
    end;

    trigger OnRename()
    begin

    end;

    local procedure testNoseries()
    begin
        // NoSeries.TestField(NoSeries);
    end;
}