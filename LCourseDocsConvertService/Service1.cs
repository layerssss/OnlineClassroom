using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading;
using System.IO;
using System.Configuration;
namespace LCourseDocsConvertService
{
    public partial class Service1 : ServiceBase
    {
        public Service1()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            this.mainThread = new Thread(this.mainLoop);
            this.mainThread.Start();
        }
        Thread mainThread;
        void mainLoop()
        {
            string[] covertProces = ConfigurationManager.AppSettings["ConvertProcessNames"].Split(',');
            int timeout = Convert.ToInt32(ConfigurationManager.AppSettings["Timeout"]);
            while (true)
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                if (!d.request.Any())
                {
                    Thread.Sleep(3000);
                    continue;
                }
                
                var req = d.request.First();
                var path = req.path;
                d.request.DeleteOnSubmit(req);
                d.SubmitChanges();
                string version = File.GetLastWriteTime(path).ToString();
                try
                {
                    if (File.ReadAllText(path + ".flashpaper.version") != version)
                    {
                        throw (new Exception());
                    }
                }
                catch
                {
                    Process.Start(ConfigurationManager.AppSettings["FlashPaperDir"] + "FlashPrinter.exe", " \"" + path + "\" -o \"" + path + ".flashpaper.swf\"").WaitForExit();


                    DateTime start = DateTime.Now;
                    bool hasTimeout = false;
                    while (true)
                    {
                        bool any = false;
                        if ((DateTime.Now - start).TotalSeconds > timeout)
                        {
                            hasTimeout = true;
                        }
                        foreach (var str in covertProces)
                        {
                            Process[] proces;
                            if ((proces = Process.GetProcessesByName(str)).Any())
                            {
                                if (!hasTimeout)
                                {
                                    Thread.Sleep(500);
                                    any = true;
                                    break;
                                }
                                proces.ToList().ForEach(tp => {
                                    try
                                    {
                                        tp.Kill();
                                        Thread.Sleep(500);
                                    }
                                    catch
                                    {
                                    }

                                });

                            }
                        }
                        if (any)
                        {
                            continue;
                        }
                        break;
                    }


                    File.WriteAllText(path + ".flashpaper.version", version);
                }
            }
        }
        protected override void OnStop()
        {
            this.mainThread.Abort();
        }
    }
}
