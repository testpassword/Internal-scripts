$MODES = @("--on", "--off")
$mode = $args[0]
if ($MODES[0] == $mode) {
    $apply_reg = "apply.reg"
    '
        Windows Registry Editor Version 5.00

        [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FeatureManagement\Overrides\0\2093230218]
        "EnabledState"=dword:00000002
        "EnabledStateOptions"=dword:00000000
    ' | Out-File -FilePath $apply_reg
    reg import .\$apply_reg
    rm $apply_reg
} elseif ($MODES[1] == $mode) {
    $undo_reg = "undo.reg"
    '
        Windows Registry Editor Version 5.00

        [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FeatureManagement\Overrides\0\2093230218]
        "EnabledState"=-
        "EnabledStateOptions"=-
    ' | Out-File -FilePath $undo_reg
    reg import .\$undo_reg
    rm $undo_reg
} else {
    Write-Error "mode set incorrectly"
}