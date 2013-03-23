﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HiddenFieldModules.Value = Request.Path.ToLower();
            ListViewModules.DataBind();
            ListView3.DataBind();
        }
    }
}