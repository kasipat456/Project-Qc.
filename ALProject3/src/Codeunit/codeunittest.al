codeunit 90001 "production sorting"
{
    trigger OnRun()
    begin

    end;

    procedure Test(DocNo: Code[20])
    var
        productgradesortingline: Record "product grade sorting line";
        productgradesortingheader: Record "product grade sorting header";
        ProductionOrder: Record "Production Order";
        NoSeriesLine: Record "No. Series Line";
    begin
        productgradesortingline.Reset();
        productgradesortingline.SetRange("Document No", DocNo);
        if not productgradesortingline.FindSet() then begin
            repeat
                ProductionOrder.Reset();
                ProductionOrder.SetRange("References Document No", productgradesortingline."Document No"); // SETRANGE หาค่า F-QC2307-xxxx
                ProductionOrder.SetRange("References Line No", productgradesortingline."Line No"); // SETRANGE หาค่า บรรทัดไลน์
                if productgradesortingline.FindSet() then begin
                    ProductionOrder.Init();
                    ProductionOrder.Status := ProductionOrder.Status::Released;
                    ProductionOrder."No." := NoSeriesLine."Last No. Used";
                    ProductionOrder."References Document No" := "DocNo";
                    ProductionOrder."Source No." := productgradesortingline."Defact item No.";
                    ProductionOrder."Creation Date" := Today;
                    ProductionOrder."Description" := productgradesortingline.Description;
                    ProductionOrder."Search Description" := productgradesortingline.Description;
                    ProductionOrder.Quantity := productgradesortingline."Defact Qty";
                    ProductionOrder."References Document No" := productgradesortingline."Document No";
                    ProductionOrder."References Line No" := productgradesortingline."Line No";
                    ProductionOrder."Defact Daecription" := productgradesortingline."Defact Daecription";
                    ProductionOrder.Insert(true);
                end;
            until productgradesortingline.Next() = 0;
        end else begin
            Message('เอกสาร %1 อยู่ในใบสั่งผลิต %2', productgradesortingline."Document No", ProductionOrder."No.");
        end;
    end;



}