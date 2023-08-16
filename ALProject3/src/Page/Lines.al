page 90026 Lines
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "product grade sorting line";
    AutoSplitKey = true;
    RefreshOnActivate = true;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Defact item No."; Rec."Defact item No.")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        producHeader: Record "product grade sorting header";
                        Item: Record Item;
                        ItemList: page "Item List";

                    begin
                        producHeader.Reset();
                        producHeader.SetRange("Document No", Rec."Document No");
                        if producHeader.FindSet() then begin
                            item.Reset();
                            item.SetCurrentKey("No."); // เลือกตารางสำหรับการใช้งาน คือ "No." ตารางที่ไม่ถูกใช้งานจะถูกละเว้น
                            item.setfilter("No.", '%1|%2', producHeader."Item C", producHeader."Item Scap"); // กำหนดตัวกรองให้กับฟิลด์ที่ระบุ 
                            // item.setfilter("No.", '%1|%2|%3', producHeader."Item A", producHeader."Item C", producHeader."Item Scap");  ออก 3 ตัว
                            if item.FindSet() then begin
                                item.Mark(true);
                            end;

                            itemList.LookupMode(true);
                            itemList.SetTableView(item);
                            if Page.RunModal(PAGE::"Item List", item) = Action::LookupOK then begin // เปิดหน้า Item List เมื่อต้องการปิดเพจ ให้กดปุ่มตกลง
                                text := item."No.";
                                Rec.Description := item.Description;
                                exit(true);
                            end
                        end;

                    end;


                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Defact Reason Code"; Rec."Defact Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Defact Daecription"; Rec."Defact Daecription")
                {
                    ApplicationArea = All;
                }
                field("Defact Qty"; Rec."Defact Qty")
                {
                    ApplicationArea = All;
                }
                field("References Production order"; Rec."References Production order")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }


    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }











}