<%@ Page Title="自我检测" Language="C#" MasterPageFile="~/MasterPages/Test.master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="LCourse.Test.Test" %>
<%@ Register assembly="CustomControl" namespace="CustomControl" tagprefix="cc1" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
.sub-option
{
    cursor:pointer;
}
.sub-option:hover
{
    background-color:#ddd;
}
.sub-option.sub-option-choosen
{
    border:3px solid #444;
}
.sub-green,.test-report-green,.sub-red,.test-report-red,.sub-blue,.test-report-blue,.test-report-count
{
    font-weight:bold;
    color:#fff;
    border-color:#000;
    border-style:dotted;
    border-width:6px;
    
}
.sub-green,.test-report-green
{
    background-color:#060;
}
.sub-red,.test-report-red
{
    background-color:#ccc;
    color:#000;
}
.sub-blue,.test-report-blue
{
    background-color:Blue;
    border-style:none;
}
.test-report-count
{
    background-color:Black;
}
#textData
{
    display:none;
}
</style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="打开下载的题集">
        下载的题集：<asp:FileUpload ID="FileUpload1" runat="server" />
        <asp:Button ID="Button2" runat="server" Text="添加" onclick="Button2_Click" />
        <input type="button" value="添加完毕" onclick="$('#WidgetPanel2').show();initTest();" />
        <asp:Label ID="Label1" runat="server"></asp:Label>
    </cc1:WidgetPanel>
    <asp:Panel ID="subs" ClientIDMode="Static" runat="server">
    </asp:Panel>
    <cc1:WidgetPanel ID="WidgetPanel2" ClientIDMode="Static" runat="server" Text="操作">
        <input type="button" id="butFinish" value="完成" onclick="showReport()" />
        <div class="test-report">总共<span class="test-report-count"></span>道题中：我有
        <span class="test-report-green"></span>个被选择正确的选项，
        <span class="test-report-blue"></span>个正确的选项没有被选择，
        <span class="test-report-red"></span>个错误的却被选择的选项。<br />
        <input type="button" id="butFilter" value="去掉题集中回答正确的问题" onclick="filterTest()" />
        <input type="button" id="butInit" value="重做该题集" onclick="initTest()" />
        <asp:Button ID="butDownCtj" runat="server" Text="下载该题集" ClientIDMode="Static" 
            onclick="Button1_Click" />
        <asp:TextBox ID="textData" runat="server" ClientIDMode="Static"></asp:TextBox></div>
    </cc1:WidgetPanel>
    <script type="text/javascript" language="javascript">
        var globalGreen;
        function showReport() {
            var red = 0, blue = 0, green = 0;

            $(".test-report").show();
            $("#butFinish").hide();
            $(".sub-option").each(function () {
                if ($(this).hasClass("sub-option-choosen")) {
                    if (!$(this).hasClass("sub-option-right")) {
                        $(this).addClass("sub-red");red++;
                    }
                }
            }).removeClass("sub-option").addClass("sub-option-static");
            $(".sub-option-right").each(function () {
                if ($(this).hasClass("sub-option-choosen")) {
                    $(this).addClass("sub-green");green++;
                } else {
                    $(this).addClass("sub-blue"); blue++;
                }
            });
            $(".test-report-red").text(red);
            $(".test-report-blue").text(blue);
            $(".test-report-green").text(green);
            $(".test-report-count").text(obj.length);
            globalGreen = green;
        }
        function filterTest() {
            $(".sub-green").parents(".sub").remove();
            var str = String("");
            $(".sub").each(function () {
                str += escape($(this).find(".sub-sort").text()) + ",";
                str += escape($(this).find(".sub-content").html()) + ",";
                $(this).find(".sub-option-static").each(function () {
                    if ($(this).hasClass("sub-option-right")) {
                        str += escape("o|");
                    }
                    str += escape($(this).text() + "\n");
                });
                str += ";";
            });
            if (str.length > 0) {
                $("#textData").val(str);
            }
            $(".sub-option-static").addClass("sub-option").removeClass("sub-option-static");
            
            msgBox("我回答正确的" + globalGreen + "个问题已经被从当前题集中删除了，现在，我可以选择重做剩下的题集或者下载剩下的题集下次再做。",showReport);
        }
        var obj;
        function initTest() {
            $(".test-report").hide();
            $("#butFinish").show();
            var str = $("#textData").val();
            str = str.substring(0, str.length - 1);
            var strs = str.split(";");
            obj = new Array();
            if (!strs.length) {
                return;
            }
            $.each(strs, function () {
                var ar = this.split(',');
                ar[0]=unescape(ar[0]);
                ar[1]=unescape(ar[1]);
                ar[2]=unescape(ar[2]);
                var found = false;
                for (var i = 0; i < obj.length; i++) {
                    if(obj[i].content==ar[1]&&obj[i].options==ar[2]){
                        found=true;
                    }
                }
                if(!found){
                    obj[obj.length] = {
                        "sort": ar[0],
                        "content": ar[1],
                        "options": ar[2]
                    };
                }
            });
            $(".sub").remove();
            $.each(obj, function () {
                var widget = $(document.createElement("div")).addClass("widget").addClass("sub").appendTo($("#subs"));
                var header = $(document.createElement("div")).addClass("widget-header").addClass("sub-sort").appendTo(widget).text(this.sort);
                var content = $(document.createElement("div")).addClass("widget-content").appendTo(widget);
                $(document.createElement("div")).addClass("sub-content").html(this.content).appendTo(content);
                var owidget = $(document.createElement("div")).addClass("widget").appendTo(content);
                var oheader = $(document.createElement("div")).addClass("widget-header").appendTo(owidget).text("选项");
                var ocontent = $(document.createElement("div")).addClass("widget-content").appendTo(owidget);
                var options = this.options.split("\n");
                $.each(options, function () {
                    if (this == "") { return; }
                    var option = $(document.createElement("div")).addClass("sub-option").appendTo(ocontent);
                    if (this.substring(0, 2) == "o|") {
                        option.text(this.substring(2, this.length)).addClass("sub-option-right");
                    } else {
                        option.text(String(this));
                    }
                });
            });
            $(".sub-option").click(function () {
                $(this).addClass("sub-option-choosen").siblings().removeClass("sub-option-choosen")
            });
            addJUI();
            msgBox("准备好了吗：在每道题下面的选项中我认为正确的选项上点击一下以选择，做完全部或者一部分后点击页面底部的完成按钮看看我做的怎么样。");
        }
    </script>
</asp:Content>
