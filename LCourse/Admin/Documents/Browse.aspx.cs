using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace LCourse.Admin.Documents
{
    public partial class Browse : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TreeView1.Nodes.Add(new TreeNode() { Text = Request.QueryString["type"], Value = "\\" });
                FillTreeNode(TreeView1.Nodes[0], "\\", Server.MapPath("/Documents/" + Request.QueryString["type"]));
                TreeView1.Nodes[0].Selected = true;
                TreeView1_SelectedNodeChanged(null, null);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.ScriptManager1, this.ScriptManager1.GetType(), "addJUI", "addJUI();", true);
            }
            refreshFileList();
        }
        void refreshFileList()
        {
            panelBrowse.Controls.Clear();
            string rootPath="/Documents/"+Request.QueryString["type"]+"";
            labelBrowse.Text = Request.QueryString["type"] + TreeView1.SelectedValue;
            foreach (string str in Directory.GetFiles(Server.MapPath(rootPath + TreeView1.SelectedValue)))
            {
                Panel line = new Panel();
                Panel floatright = new Panel();
                floatright.CssClass = "floatright";
                line.Controls.Add(new HiddenField(){Value=str});
                line.Controls.Add(floatright);
                line.Controls.Add(new Label() { Text = str.Substring(str.LastIndexOf("\\") + 1) });
                line.CssClass = "widget-content";
                panelBrowse.Controls.Add(line);

                if (str.EndsWith(".html"))
                {
                    LinkButton butEdit = new LinkButton();
                    butEdit.Text = "编辑";
                    butEdit.CssClass = "button";
                    butEdit.Click += new EventHandler(butEdit_Click);
                    floatright.Controls.Add(butEdit);
                }


                HyperLink linkView = new HyperLink();
                linkView.Text = "查看";
                linkView.CssClass = "button";
                linkView.NavigateUrl = str.Substring(Server.MapPath("/").Length-1).Replace('\\','/');
                linkView.Target = "_blank";
                floatright.Controls.Add(linkView);

                LinkButton butRenameFile = new LinkButton();
                butRenameFile.Text = "重命名";
                butRenameFile.CssClass = "button";
                butRenameFile.Click += new EventHandler(butRenameFile_Click);
                floatright.Controls.Add(butRenameFile);

                LinkButton butDel = new LinkButton();
                butDel.Text = "删除";
                butDel.CssClass = "button";
                butDel.Click += new EventHandler(butDel_Click);
                floatright.Controls.Add(butDel);
            }
            butRenameFolder.Visible = butDelFolder.Visible = (TreeView1.SelectedValue != "\\");
        }

        void butDel_Click(object sender, EventArgs e)
        {
            string path = ((HiddenField)(((LinkButton)sender).Parent.Parent.Controls[0])).Value;
            File.Delete(path);
            refreshFileList();

        }
        void butRenameFile_Click(object sender, EventArgs e)
        {

            string path = ((HiddenField)(((LinkButton)sender).Parent.Parent.Controls[0])).Value;
            hidRenameFile.Value = path;
            string fname = path.Substring(path.LastIndexOf('\\') + 1);
            if (fname.Contains('.'))
            {
                textRenameFile.Text = fname.Remove(fname.LastIndexOf('.'));
            }
            else
            {
                textRenameFile.Text = fname;
            }
            labelRenameFile.Text = string.Format("重命名文件“{0}”", textRenameFile.Text);
            MultiView1.SetActiveView(viewRenameFile);
        }
        void FillTreeNode(TreeNode node,string path,string rootPath)
        {
            foreach (string str in System.IO.Directory.GetDirectories(rootPath + path))
            {
                TreeNode subNode = new TreeNode()
                {
                    Text = str.Substring(str.LastIndexOf('\\') + 1),
                    Value = str.Substring(rootPath.Length)
                };
                node.ChildNodes.Add(subNode);
                FillTreeNode(subNode, subNode.Value + "\\", rootPath);
            }
        }

        protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
        {
            MultiView1.SetActiveView(viewBrowse);
        }

        void butEdit_Click(object sender, EventArgs e)
        {
            string path = ((HiddenField)(((LinkButton)sender).Parent.Parent.Controls[0])).Value;
            hidEdit.Value = path;
            textEdit.Text = File.ReadAllText(path);
            labelEdit.Text = path.Substring(path.LastIndexOf('\\') + 1);
            MultiView1.SetActiveView(viewEdit);
        }

        protected void butEditCancel_Click(object sender, EventArgs e)
        {

            MultiView1.SetActiveView(viewBrowse);
        }

        protected void butEditOk_Click(object sender, EventArgs e)
        {
            File.WriteAllText(hidEdit.Value, textEdit.Text);
            MultiView1.SetActiveView(viewBrowse);
        }

        protected void butRenameFileCancel_Click(object sender, EventArgs e)
        {

            MultiView1.SetActiveView(viewBrowse);
        }

        protected void butRenameFolderCancel_Click(object sender, EventArgs e)
        {

            MultiView1.SetActiveView(viewBrowse);
        }

        protected void butRenameFileOk_Click(object sender, EventArgs e)
        {

            string path = hidRenameFile.Value;
            
            string fname = path.Substring(path.LastIndexOf('\\') + 1);
            if (fname.Contains('.'))
            {
                File.Move(path, path.Remove(path.Length - fname.Length) + textRenameFile.Text + fname.Substring(fname.LastIndexOf('.')));
            }
            else
            {
                File.Move(path, path.Remove(path.Length - fname.Length) + textRenameFile.Text);
            }
            refreshFileList();
            MultiView1.SetActiveView(viewBrowse);
        }

        protected void butNewFolder_Click(object sender, EventArgs e)
        {
            if (textNew.Text != "")
            {
                string rootPath = "/Documents/" + Request.QueryString["type"] + "";
                Directory.CreateDirectory(Server.MapPath(rootPath + TreeView1.SelectedValue + "\\" + textNew.Text));
                Response.Redirect("Browse.aspx?type=" + Request.QueryString["type"]);
            }
        }

        protected void butDelFolder_Click(object sender, EventArgs e)
        {
            string rootPath = "/Documents/" + Request.QueryString["type"] + "";
            Directory.Delete(Server.MapPath(rootPath + TreeView1.SelectedValue), true);
            Response.Redirect("Browse.aspx?type=" + Request.QueryString["type"]);
        }

        protected void butNewHtml_Click(object sender, EventArgs e)
        {
            if (textNew.Text != "")
            {
                string rootPath = "/Documents/" + Request.QueryString["type"] + "";
                File.WriteAllText(Server.MapPath(rootPath + TreeView1.SelectedValue + "\\" + textNew.Text + ".html"), "（暂无内容）");
                hidEdit.Value = Server.MapPath(rootPath + TreeView1.SelectedValue + "\\" + textNew.Text + ".html");
                textEdit.Text = "（暂无内容）";
                labelEdit.Text = textNew.Text + ".html";
                MultiView1.SetActiveView(viewEdit);
                textNew.Text = "";
            }
        }
    }
}