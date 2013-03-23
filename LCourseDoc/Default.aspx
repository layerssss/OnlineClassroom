<%@ Page Title="主要特性" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="LCourseDoc._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
    内容模块</h2>
<ul>
    <li>三个顶级分类“课程概况”、“课程学习”、“程序下载”</li>
    <li>支持多级子类别</li>
    <li>支持doc,xls,ppt,docx,xlsx,pptx,pdf格式文档的在线显示，并允许学生下载原文件</li>
    <li>支持mp4,mov,f4v,flv,3gp,3g2,acc,m4a,mp3格式的多媒体文件的在线播放，并允许学生下载原文件</li>
    <li>支持swf格式的flash的在线播放，并允许学生下载原文件</li>
    <li>支持rar,zip,7z格式的压缩存放，只允许下载</li>
    <li>支持html文件内容(富页面)的存放和显示，并可以进行在线编辑，也可以在页面中嵌入上传的图片或Flash</li>
    <li>使用Ajax技术实现每个顶级页面下的界面，交互流畅</li>
    <li>后台管理系统使用Ajax实现，方便各种管理操作</li>
    <li>所有内容以文件形式储存，和数据库无关，避免了数据库体积过大时的数据库运行开销，也方便日后内容的管理</li>
</ul>
<h2>
    学生模块</h2>
<ul>
    <li>支持以班级为单位或以单个学生为单位管理学生和进行与学生相关的操作</li>
    <li>向学生布置主观题型的作业，并查收</li>
    <li>可以对学生的上线次数，在线时间，作业历史直观地进行查看</li>
    <li>学生可以查看班级的成员</li>
    <li>教师可以向学生发送消息，消息通过smtp服务器发送到学生自己填写的电子邮件地址</li>
</ul>
<h2>
    讨论区模块</h2>
<ul>
    <li>支持多个讨论区板块</li>
    <li>用户可以在讨论区发布主题，回复主题</li>
    <li>用户可以关注特定的讨论区主题，当被关注的主题有其他用户的新回复时，将通过电子邮件的形式通知用户</li>
</ul>
<h2>
    在线测试模块</h2>
<ul>
    <li>在线测试为学生自愿完成，系统不会记录学生的成绩</li>
    <li>在线测试题目的形式为单选题</li>
    <li>在线答题，系统会自动计算出学生的成绩并显示</li>
    <li>每套题目的介绍和每一道题的内容支持html格式(富页面)，并可以在管理后台使用在线编辑器编辑</li>
</ul>
<h2>
    整体特性</h2>
    <ul>
        <li>身份验证管理采用Asp.net内置的Membership组件，安全性较高</li>
        <li>使用.Net平台架构，代码量少，易读，可扩展性好</li>
        <li>客户端兼容度高，兼容目前大部分主流浏览器</li>
    </ul>
    </asp:Content>
