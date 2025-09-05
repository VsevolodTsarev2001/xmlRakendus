<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="xmlRakendus.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <h1>XML katsetamine: Minu sugupuu</h1>

        <div>
            <asp:Xml runat="server"
                DocumentSource="~/minusugupuu.xml"
                TransformSource="~/minusuguparing.xslt">
            </asp:Xml>
        </div>    
    </main>
</asp:Content>
