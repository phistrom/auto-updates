:log info "Checking for system updates..."
:local status [/system package update check-for-updates duration=5s as-value];
:local latest ($status->"latest-version")
:local installed ($status->"installed-version")
:if ($latest != $installed) do={
    :log info ("Detected new version " . $latest . ". Installing...")
    /system package update install
} else={
    :log info ("Our version (" . $installed . ") is already the latest version.")
}
