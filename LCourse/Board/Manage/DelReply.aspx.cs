﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board.Manage
{
    public partial class DelReply : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            DataClasses1DataContext d = new DataClasses1DataContext();
            d.reply.DeleteOnSubmit(d.reply.First(tr => tr.id.ToString() == Request.QueryString["rid"]));
            d.SubmitChanges();
            Response.Redirect(Request.UrlReferrer.ToString());
        }
    }
}