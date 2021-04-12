@echo off

REM Edit windows default photo saving '.jfif' to '.jpg'

echo changing root user
REG ADD "HKCR\MIME\Database\Content Type\image/jpeg" /v "Extension" /t "REG_SZ" /d ".jpg" /f
REG QUERY "HKCR\MIME\Database\Content Type\image/jpeg" /f "Extension" /e

@echo,
@echo,

echo changing local user
REG ADD "HKCU\Software\Classes\MIME\Database\Content Type\image/jpeg" /t "REG_SZ" /d ".jpg" /f
REG QUERY "HKCU\Software\Classes\MIME\Database\Content Type\image/jpeg" /f "Extension" /e

echo Done
pause
