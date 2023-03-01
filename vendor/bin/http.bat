@ECHO OFF
setlocal DISABLEDELAYEDEXPANSION
SET BIN_TARGET=%~dp0/../patriziotomato/edgegrid-client/bin/http
php "%BIN_TARGET%" %*
