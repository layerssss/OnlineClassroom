using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Runtime.InteropServices;
using System.Security.Principal;
using System.Security.Permissions;
using System.Diagnostics;
namespace LCourse.Private
{
    public class Impersonater
    {
        public const int LOGON32_LOGON_INTERACTIVE = 2;
        public const int LOGON32_PROVIDER_DEFAULT = 0;
        WindowsImpersonationContext impersonationContext;
        [DllImport("advapi32.dll")]
        public static extern int LogonUserA(String lpszUserName,
        String lpszDomain,
        String lpszPassword,
        int dwLogonType,
        int dwLogonProvider,
        ref IntPtr phToken);
        [DllImport("advapi32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern int DuplicateToken(IntPtr hToken,
        int impersonationLevel,
        ref IntPtr hNewToken);

        [DllImport("advapi32.dll", EntryPoint="DuplicateTokenEx")]
		public extern static bool DuplicateTokenEx(IntPtr ExistingTokenHandle, uint dwDesiredAccess, 
			ref SECURITY_ATTRIBUTES lpThreadAttributes, int TokenType,
			int ImpersonationLevel, ref IntPtr DuplicateTokenHandle);
        [DllImport("advapi32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern bool RevertToSelf();
        [DllImport("kernel32.dll", EntryPoint = "CloseHandle", SetLastError = true, CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall)]
        public extern static bool CloseHandle(IntPtr handle);
        [DllImport("advapi32.dll", EntryPoint = "CreateProcessAsUser", SetLastError = true, CharSet = CharSet.Ansi, CallingConvention = CallingConvention.StdCall)]
        public extern static bool CreateProcessAsUser(IntPtr hToken, String lpApplicationName, String lpCommandLine, ref SECURITY_ATTRIBUTES lpProcessAttributes,
            ref SECURITY_ATTRIBUTES lpThreadAttributes, bool bInheritHandle, int dwCreationFlags, IntPtr lpEnvironment,
            String lpCurrentDirectory, ref STARTUPINFO lpStartupInfo, out PROCESS_INFORMATION lpProcessInformation);


        public bool impersonateValidUser(String userName, String domain, String password)
        {
            WindowsIdentity tempWindowsIdentity;
            IntPtr token = IntPtr.Zero;
            IntPtr tokenDuplicate = IntPtr.Zero;
            if (RevertToSelf())
            {
                if (LogonUserA(userName, domain, password,
                LOGON32_LOGON_INTERACTIVE,
                LOGON32_PROVIDER_DEFAULT, ref token) != 0)
                {
                    if (DuplicateToken(token, 2, ref tokenDuplicate) != 0)
                    {
                        tempWindowsIdentity = new
                        WindowsIdentity(tokenDuplicate);
                        impersonationContext =
                        tempWindowsIdentity.Impersonate();
                        if (impersonationContext != null)
                        {
                            CloseHandle(token);
                            CloseHandle(tokenDuplicate);
                            return true;
                        }
                    }
                }
            }
            if (token != IntPtr.Zero)
                CloseHandle(token);
            if (tokenDuplicate != IntPtr.Zero)
                CloseHandle(tokenDuplicate);
            return false;
        }

        public void undoImpersonation()
        {
            impersonationContext.Undo();
        }
        public void RunWin32Command(string commandLinePath,string curPath,bool waitForExit)
        {
            IntPtr Token = new IntPtr(0);
            IntPtr DupedToken = new IntPtr(0);
            bool ret;


            SECURITY_ATTRIBUTES sa = new SECURITY_ATTRIBUTES();
            sa.bInheritHandle = false;
            sa.Length = Marshal.SizeOf(sa);
            sa.lpSecurityDescriptor = (IntPtr)0;

            Token = WindowsIdentity.GetCurrent().Token;

            const uint GENERIC_ALL = 0x10000000;

            const int SecurityImpersonation = 2;
            const int TokenType = 1;

            ret = DuplicateTokenEx(Token, GENERIC_ALL, ref sa, SecurityImpersonation, TokenType, ref DupedToken);

            if (ret == false)
                throw (new Exception(Marshal.GetLastWin32Error().ToString()));

            STARTUPINFO si = new STARTUPINFO();
            si.cb = Marshal.SizeOf(si);
            si.lpDesktop = "";


            PROCESS_INFORMATION pi = new PROCESS_INFORMATION();
            ret = CreateProcessAsUser(DupedToken, null, commandLinePath, ref sa, ref sa, false, 0, (IntPtr)0, curPath, ref si, out pi);

            if (ret == false)
                throw (new Exception("CreateProcessAsUser failed with " + Marshal.GetLastWin32Error()));
            else
            {
                if (waitForExit)
                {
                    Process p = Process.GetProcessById((int)pi.dwProcessId);
                    p.WaitForExit();
                }
                CloseHandle(pi.hProcess);
                CloseHandle(pi.hThread);
            }

            ret = CloseHandle(DupedToken);
            if (ret == false)
                throw (new Exception(Marshal.GetLastWin32Error().ToString()));

        }
        [StructLayout(LayoutKind.Sequential)]
        public struct STARTUPINFO
        {
            public int cb;
            public String lpReserved;
            public String lpDesktop;
            public String lpTitle;
            public uint dwX;
            public uint dwY;
            public uint dwXSize;
            public uint dwYSize;
            public uint dwXCountChars;
            public uint dwYCountChars;
            public uint dwFillAttribute;
            public uint dwFlags;
            public short wShowWindow;
            public short cbReserved2;
            public IntPtr lpReserved2;
            public IntPtr hStdInput;
            public IntPtr hStdOutput;
            public IntPtr hStdError;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct PROCESS_INFORMATION
        {
            public IntPtr hProcess;
            public IntPtr hThread;
            public uint dwProcessId;
            public uint dwThreadId;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct SECURITY_ATTRIBUTES
        {
            public int Length;
            public IntPtr lpSecurityDescriptor;
            public bool bInheritHandle;
        }
    }
}