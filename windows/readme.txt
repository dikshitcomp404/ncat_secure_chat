Windows ncat LAN Chat
----------------
1. Place nchat-host.bat and nchat-client.bat in the same folder.
2. Ensure ncat.exe is installed (from Nmap).
3. Run the set_path_var.bat (this will make the scripts usable directly as a terminal command)
3. Run:
   nchat-host.bat   # to host
   nchat-connect.bat # to connect (prompts for IP if not provided)
Port used: 1234
Stop with Ctrl+C.