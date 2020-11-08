#creates Logonscript
$content = "@echo off`nnet use p: \\ms\PublicShare" | out-file -filepath \\intranet.mijnschool.be\NETLOGON\login.bat