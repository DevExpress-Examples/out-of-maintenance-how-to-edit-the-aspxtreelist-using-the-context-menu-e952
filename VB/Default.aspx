<%@ Page Language="vb" AutoEventWireup="true"  CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ register Assembly="DevExpress.Web.v13.1" Namespace="DevExpress.Web" TagPrefix="dxm" %>

<%@ register Assembly="DevExpress.Web.v13.1" Namespace="DevExpress.Web"
    TagPrefix="dxe" %>

<%@ register Assembly="DevExpress.Web.ASPxTreeList.v13.1" Namespace="DevExpress.Web.ASPxTreeList"
    TagPrefix="dxwtl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>How to edit the ASPxTreeList using the context menu</title>
    <script type ="text/javascript">
    var currentNodeKey;
    function ShowMenu(nodeKey, x, y)
    {
      clientPopupMenu.ShowAtPos(x,y);
      currentNodeKey = nodeKey;
    }
    function ProcessNodeClick(itemName)
    {
      switch (itemName) 
      {
        case "new": 
           {
             if (clientTreeList.IsEditing())
               {
                 clientTreeList.UpdateEdit()
               }
             clientTreeList.StartEditNewNode(); 
             break;
           }
        case "newchild": 
           {
             if (clientTreeList.IsEditing())
               {
                 clientTreeList.UpdateEdit()
               }
             clientTreeList.StartEditNewNode(currentNodeKey); 
             break;
           }
        case "edt": 
           {
            if (clientTreeList.IsEditing())
               {
                 clientTreeList.UpdateEdit()
               }
            clientTreeList.StartEdit(currentNodeKey); 
            break;
           }
        case "del": 
           {
            if (clientTreeList.IsEditing())
               {
                 clientTreeList.UpdateEdit()
               }
            clientTreeList.DeleteNode(currentNodeKey); 
            break;
           }
        default: return;
      }

    }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dxwtl:aspxtreelist ID="ASPxTreeList1" runat="server" AutoGenerateColumns="False" DataSourceID="AccessDataSource1" KeyFieldName="CategoryID" ParentFieldName="ParentID" ClientInstanceName="clientTreeList">
            <columns>
                <dxwtl:treelisttextcolumn FieldName="CategoryID" VisibleIndex ="0">
                </dxwtl:treelisttextcolumn>
                <dxwtl:treelisttextcolumn FieldName="CategoryName" VisibleIndex="1">
                </dxwtl:treelisttextcolumn>
                <dxwtl:treelisttextcolumn FieldName="Description" VisibleIndex="2">
                </dxwtl:treelisttextcolumn>
            </columns>
            <clientsideevents ContextMenu="function(s, e) {
           if (e.objectType != 'Node') return;
           s.SetFocusedNodeKey(e.objectKey);
           var mouseX = ASPxClientUtils.GetEventX(e.htmlEvent);
           var mouseY = ASPxClientUtils.GetEventY(e.htmlEvent);   
           ShowMenu(e.objectKey, mouseX, mouseY);
         }" />
            <settingsbehavior AllowFocusedNode="True" FocusNodeOnLoad="False" />
            <settingsediting ConfirmDelete="False" Mode="EditFormAndDisplayNode" />
        </dxwtl:aspxtreelist>
        &nbsp;
        <asp:accessdatasource ID="AccessDataSource1" runat="server" DataFile="App_Data/categories.mdb"
            SelectCommand="SELECT [CategoryID], [ParentID], [CategoryName], [Description] FROM [Categories]" DeleteCommand="DELETE FROM [Categories] WHERE [CategoryID] = ?" InsertCommand="INSERT INTO [Categories] ([CategoryID], [ParentID], [CategoryName], [Description]) VALUES (?, ?, ?, ?)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [Categories] SET [CategoryName] = ?, [Description] = ?, [ParentID] = ? WHERE [CategoryID] = ?">
            <deleteparameters>
                <asp:parameter Name="original_CategoryID" Type="Int32" />
            </deleteparameters>
            <updateparameters>
                <asp:parameter Name="CategoryName" Type="String" />
                <asp:parameter Name="Description" Type="String" />
                <asp:parameter Name="ParentID" Type="Int32" />
                <asp:parameter Name="original_CategoryID" Type="Int32" />
            </updateparameters>
            <insertparameters>
                <asp:parameter Name="CategoryID" Type="Int32" />
                <asp:parameter Name="ParentID" Type="Int32" />
                <asp:parameter Name="CategoryName" Type="String" />
                <asp:parameter Name="Description" Type="String" />
            </insertparameters>
        </asp:accessdatasource>
        <dxm:aspxpopupmenu ID="ASPxPopupMenu1" runat="server" ClientInstanceName="clientPopupMenu">
            <items>
                <dxm:menuitem Name="new" Text="New">
                </dxm:menuitem>
                <dxm:menuitem Name="newchild" Text="New Child">
                </dxm:menuitem>
                <dxm:menuitem Name="edt" Text="Edit">
                </dxm:menuitem>
                <dxm:menuitem Name="del" Text="Delete">
                </dxm:menuitem>
            </items>
            <clientsideevents ItemClick="function(s, e) { ProcessNodeClick (e.item.name);}" />
        </dxm:aspxpopupmenu>

    </div>
    </form>
</body>
</html>