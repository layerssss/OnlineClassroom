var myUrl = {
    // private method for UTF-8 encoding
    _utf8_encode: function (string) {
        string = string.replace(/\r\n/g, "\n");
        var utftext = "";
        for (var n = 0; n < string.length; n++) {

            var c = string.charCodeAt(n);
            if (c < 128) {
                utftext += String.fromCharCode(c);
            }
            else if ((c > 127) && (c < 2048)) {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            }
            else {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }

        }

        return utftext;
    },

    // private method for UTF-8 decoding
    _utf8_decode: function (utftext) {
        var string = "";
        var i = 0;
        var c = c1 = c2 = 0;

        while (i < utftext.length) {

            c = utftext.charCodeAt(i);

            if (c < 128) {
                string += String.fromCharCode(c);
                i++;
            }
            else if ((c > 191) && (c < 224)) {
                c2 = utftext.charCodeAt(i + 1);
                string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
                i += 2;
            }
            else {
                c2 = utftext.charCodeAt(i + 1);
                c3 = utftext.charCodeAt(i + 2);
                string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                i += 3;
            }

        }

        return string;
    },
    // public method for url encoding
    encode: function (string) {
        return escape(this._utf8_encode(string));
    },

    // public method for url decoding
    decode: function (string) {
        return this._utf8_decode(unescape(string));
    }

};
function linkAjax() {
    $(function () {
        $(".ajaxLink:not(.ajaxLinkStatic)").click(function () {
            opendoc($(this).attr("title"));
            return false;
        }).addClass("ajaxLinkStatic").each(function () {//swap href and title
            var title = $(this).attr("title");
            var href = myUrl.decode($(this).attr("href").substring(10))
            if ($.browser.msie && ($.browser.version == '6.0' || $.browser.version == '7.0')) {
                href = href.substring(href.indexOf('/')+10);
            }
            $(this).attr("title", href);
            $(this).attr("href", title);
        });
    });
}
function opendoc(path) {
    $("#main").load("LoadDocument.aspx?path=" + myUrl.encode(path) + "&time=" + (new Date()).getTime().toString(), null, function () {
        addJUI();
        sizeChange();
        $(".iframeContent").hide();
        $(".iframeContent").show();

    }).html("正在打开，请稍候……");
}
function sizeChange() {
    $(".iframeContent").height($(window).height() - 203);
    if (onlineListAtChat) {
        $(".showonlinelist").width($(window).width() - 100);
        $("#panelContent").height($(window).height() - 190);
        $("#textSend").width($(window).width() - 200);
    } else {
        $(".showonlinelist").width($("#nav").width() - 60);
    }
}
function msgBox(msg, callback, title,moreOptionsFn) {
    if (!title) {
        title = "提示";
    }
    var options = { modal: true, title: title, buttons: { '确定': function () { $(this).dialog('close'); if (callback) { callback(); } } } };
    if (moreOptionsFn) {
        moreOptionsFn(options);
    }
    return $(document.createElement("div")).appendTo("body").html(msg).dialog(options);
}
function menuAccordion() {
    $(".menu:not(.menuStatic)").accordion({
        "collapsible": true,
        "icons": "",
        "active": false,
        "autoHeight": false,
        "change": function (e, u) {
            if (u.newContent) {
                var newPath = $(u.newContent).find("a.ajaxUrl").text("加载中……");
                if (newPath.length != 0) {
                    $(u.newContent).load(
                                newPath.attr("href") + "&time=" + (new Date()).getTime().toString(),
                                null,
                                function () {
                                    menuAccordion();
                                    linkAjax();
                                }
                            );
                    $(".ui-accordion-content").css("padding", "4px 7px");
                }
            }
        }
    }).addClass("menuStatic");

}
function addJUI() {
    $(".button:not(.buttonStatic)").addClass("ui-state-default").hover(function () {
        $(this).addClass("ui-state-hover");
    }, function () {
        $(this).removeClass("ui-state-hover");
    }).addClass("buttonStatic");
    $(".mediaholder:not(.mediaholderStatic)").each(function () {
        jwplayer("mediaholder").setup({
            flashplayer: "/jwplayer/player.swf",
            file: $(this).attr("href"),
            height: "100%",
            width: "100%",
            autostart: true
        });
    }).addClass("mediaholderStatic");
    $(".widget").addClass("ui-widget");
    $(".widget-content").addClass("ui-widget-content");
    $(".widget-header").addClass("ui-widget-header");
    $(".hoverlight:not(.hoverlightStatic)").hover(function () {
        $(document.createElement("div")).css({
            "width": $(this).width() + 7,
            "height": $(this).height() + 12,
            "position": "absolute",
            "left": "-1px",
            "top": ($.browser.msie && $.browser.version == "8.0") ? "-8px" : "-8px",
            "z-index": "8"
        }).text(" ").addClass("hoverlight_light ui-state-hover").appendTo($(this).parent()).hide().fadeTo(500, 0.5);
    }, function () {
        $(this).parent().children(".hoverlight_light").fadeTo(500, 0, function () {
            $(this).remove();
        });
    }).addClass("hoverlightStatic");
    
}
$(function () {
    addJUI();
    window.onresize = sizeChange;
    sizeChange();
    menuAccordion();
    $(".menu").accordion("activate", 0);
    $(".buttonDel").button({
        "text": false,
        "icons": {
            "primary": "ui-icon-circle-close"
        }
    });
    $(".accordion").accordion({ "collapsible": true,
        "icons": "",
        "active": false,
        "autoHeight": false
    });
    var interval;
    $(".showonlinebutton").click(toggleOnlineList);
    $(".openchat").click(function () {
        window.open("/Board/Chat.aspx","_blank","toolbars=no,scrollbars=no,resizable=yes");
        return false;
    });
});
var onlineListOn = false;
var onlineListAtChat = false;
function toggleOnlineList() {
    if (!onlineListOn) {
        $(document.createElement("div")).text("读取中，请稍候……").addClass("ui-widget-content")
        .css({
            "padding": "10px 10px 20px 20px"
        })
        .appendTo($(document.createElement("div")).addClass("ui-widget-header")
        .html("<a href='#' title='发送消息' onclick='toggleOnlineList()' class='ui-state-default' style='float:right;padding:0px;cursor:pointer;'><span class='ui-icon ui-icon-closethick'/></a>在线用户列表")
        .css({
            "padding": "8px 8px 8px 8px",
            "width": "auto",
            "height": 20
        })
        .appendTo($(document.createElement("div")).addClass("ui-widget showonlinelist")).parent()).parent().appendTo("body").css({
            "position": "absolute",
            "float": "left",
            "left": 50,
            "top": 50,
            "z-index": 12,
            "overflow": "hidden"
        }).hide();
        loadOnlineList(function () {
            $(".showonlinelist").show("blind");
        });
        interval = setInterval("loadOnlineList(function(){});", 5000);
    } else {
        $(".showonlinelist").fadeOut(300, function () {
            $(this).remove();
        })
        clearInterval(interval);
    }
    onlineListOn = !onlineListOn;
    return false;
}
function loadOnlineList(fn) {
    var url = "/User/Online.aspx?time=";
    if (onlineListAtChat) {
        url = "/Board/ChatOnline.aspx?time=";
    }
    $.ajax({
        "url": url + escape((new Date()).getTime()),
        "dateType": "json",
        "success": function (data) {
            var str = "";
            $.each(data, function () {
                str += "<p style='display:block;float:left;border-bottom:1px solid #ccc;padding:4px;width:100px;margin:10px;'><a href='#' title='发送消息' onclick='openMsgWin(\"/User/Msg.aspx?uid=" + this.id + "\",270)' class='ui-state-default' style='float:right;padding:0px;cursor:pointer;'><span class='ui-icon ui-icon-comment'/></a><a title='查看资料' href='/Board/ViewUser.aspx?uid=" + this.id + "'>" + this.showname + "</a></p>";
            });
            str += "<p style='clear:both'>　</p>"
            $(".showonlinelist div.ui-widget-content").html(str);
            sizeChange();
            fn();
        }
    });
}
function openMsgWin(url, width, target) {
    if (!target) {
        target = "_blank";
    }
    var win = window.open(url, target, "toolbars=no,width=800px,height=" + width + "px");
}
